require 'json'
require 'yaml'
require 'fileutils'
require 'open-uri'
require 'date'
require 'uri'
require 'cgi'

def gist_embed_html(gist_url, file_name = nil)
  js_url = "#{gist_url}.js"
  js_url += "?file=#{CGI.escape(file_name)}" if file_name && !file_name.empty?

  <<~HTML.strip
    <script src="#{js_url}"></script>
    <noscript><a href="#{gist_url}">View gist</a></noscript>
  HTML
end

def convert_devto_liquid_tags(markdown)
  converted = markdown.dup

  converted.gsub!(/\{\%\s*link\s+([^\s%]+)\s*\%\}/m) do
    url = Regexp.last_match(1)
    "[#{url}](#{url})"
  end

  converted.gsub!(/\{\%\s*comment\s+([^\s%]+)\s*\%\}/m) do
    url = Regexp.last_match(1)
    "[View comment](#{url})"
  end

  converted.gsub!(/\{\%\s*github\s+([^\s%]+)\s*\%\}/m) do
    url = Regexp.last_match(1)
    if url =~ /github\.com\/([^\/\s]+\/[^\/\s#?]+)/
      "[GitHub: #{Regexp.last_match(1)}](#{url})"
    else
      "[GitHub link](#{url})"
    end
  end

  converted.gsub!(/\{\%\s*gist\s+([^\s%]+)(?:\s+file=([^\s%]+))?\s*\%\}/m) do
    gist_url = Regexp.last_match(1)
    file_name = Regexp.last_match(2)
    gist_embed_html(gist_url, file_name)
  end

  converted.gsub!(/\{\%\s*tweet\s+(\d+)\s*\%\}/m) do
    tweet_id = Regexp.last_match(1)
    <<~HTML.strip
      <blockquote class="twitter-tweet"><a href="https://twitter.com/i/web/status/#{tweet_id}">Tweet</a></blockquote>
      <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    HTML
  end

  converted
end

# Point this to your JSON export file
json_file = "devto-export-2026-05-27/articles.json" 
images_dest_dir = "assets/images/posts"
imported_posts = [] 

FileUtils.mkdir_p(images_dest_dir)

# Read and parse the JSON file
unless File.exist?(json_file)
  puts "Could not find #{json_file}. Please ensure it is in the same directory."
  exit
end

articles = JSON.parse(File.read(json_file))

articles.each do |article|
  title = article['title']
  
  # --- THE DUPLICATE FILTER ---
  canonical = article['canonical_url']
  if canonical && (canonical.include?('yechiel.me') || canonical.include?('medium.com'))
    puts "⏭️  Skipping cross-post: '#{title}'"
    next
  end
  # ----------------------------

  # 1. Extract Core Meta
  # Fallback to created_at if published_at is null
  date_raw = article['published_at'] || article['created_at'] 
  date = date_raw ? DateTime.parse(date_raw) : DateTime.now
  
  tags = article['cached_tag_list'] ? article['cached_tag_list'].split(',').map(&:strip) : []
  
  # Use Dev.to's provided slug if available, otherwise generate one
  slug = article['slug'] || title.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '')
  jekyll_filename = "_posts/#{date.strftime('%Y-%m-%d')}-#{slug}.md"

  # 2. Extract and Clean the Body Markdown
  body = article['body_markdown'] || ""
  cover_image_url = article['main_image']

  # If the body contains old hardcoded YAML frontmatter, strip it out.
  # We will also check it for a cover image just in case Dev.to left it out of the JSON root.
  if body =~ /^---\s*\r?\n(.*?)\r?\n---\s*\r?\n(.*)/m
    raw_frontmatter = $1
    body = $2 # Keep only the pure markdown content
    
    parsed_fm = YAML.safe_load(raw_frontmatter, permitted_classes: [Date, Time]) || {}
    cover_image_url ||= parsed_fm['cover_image'] || parsed_fm['main_image']
  end

  cover_image_local = nil

  # 3. Process Cover Image
  if cover_image_url && cover_image_url.start_with?('http')
    begin
      ext = File.extname(URI.parse(cover_image_url).path)
      ext = '.jpg' if ext.empty?
      
      img_filename = "#{date.strftime('%Y-%m-%d')}-#{slug}-cover#{ext}"
      img_path = File.join(images_dest_dir, img_filename)

      unless File.exist?(img_path)
        File.open(img_path, 'wb') { |f| f.write(URI.open(cover_image_url, "User-Agent" => "Mozilla/5.0").read) }
      end
      cover_image_local = "/#{img_path}"
    rescue => e
      puts "  [Warning] Failed to download cover image for #{title}: #{e.message}"
    end
  end

  # 4. Process Inline Markdown Images
  body.gsub!(/!\[(.*?)\]\((https?:\/\/[^\)]+)\)/) do |match|
    alt_text = $1
    img_url = $2
    
    begin
      ext = File.extname(URI.parse(img_url).path)
      ext = '.jpg' if ext.empty? || ext.include?('%')
      
      hash = img_url.hash.abs.to_s(16)[0..5]
      local_img_name = "#{date.strftime('%Y-%m-%d')}-#{slug}-#{hash}#{ext}"
      local_img_path = File.join(images_dest_dir, local_img_name)

      unless File.exist?(local_img_path)
        File.open(local_img_path, 'wb') { |f| f.write(URI.open(img_url, "User-Agent" => "Mozilla/5.0").read) }
      end
      
      "![#{alt_text}](/#{local_img_path})"
    rescue => e
      puts "  [Warning] Failed to download inline image in #{title}: #{e.message}"
      match
    end
  end

  # 4.5 Convert Dev.to Liquid tags to Markdown/HTML supported by Jekyll
  body = convert_devto_liquid_tags(body)

  # 5. Build Minimal Mistakes Frontmatter
  new_frontmatter = "---\n"
  new_frontmatter += "title: \"#{title.gsub('"', '\"')}\"\n"
  new_frontmatter += "date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}\n"
  new_frontmatter += "permalink: /#{slug}\n"
  
  if cover_image_local
    new_frontmatter += "header:\n"
    new_frontmatter += "  teaser: #{cover_image_local}\n"
  end

  new_frontmatter += "tags:\n"
  tags.each { |t| new_frontmatter += "  - #{t}\n" } unless tags.empty?
  
  new_frontmatter += "---\n\n"

  # 6. Write to Jekyll _posts directory
  File.write(jekyll_filename, new_frontmatter + body)
  puts "✅ Converted native Dev.to post: #{title}"
  
  # Track for the final summary (only if it wasn't a draft)
  if article['published']
    imported_posts << { title: title, target_url: "https://blog.yechiel.me/#{slug}" }
  end
end

# --- THE TEXT FILE REPORT ---
report_filename = "devto_canonical_urls.txt"

File.open(report_filename, "w") do |file|
  file.puts "="*60
  file.puts "📋 ACTION REQUIRED: Update Canonical URLs on Dev.to"
  file.puts "="*60
  file.puts "The following posts were successfully migrated to your blog."
  file.puts "You can now go to Dev.to, edit these specific posts, and paste"
  file.puts "the provided URLs into their 'Canonical URL' field."
  file.puts "-"*60

  imported_posts.each do |post|
    file.puts "📝 Title: #{post[:title]}"
    file.puts "🔗 Paste: #{post[:target_url]}"
    file.puts "-"*60
  end
end

puts "\n" + "="*60
puts "🎉 Dev.to JSON Migration 100% complete!"
puts "📄 A checklist report has been saved to: #{report_filename}"
puts "="*60