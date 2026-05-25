require 'nokogiri'
require 'reverse_markdown'
require 'date'
require 'fileutils'
require 'open-uri'

posts_dir = "medium_archive/posts/*.html"
images_dest_dir = "assets/images/posts"

FileUtils.mkdir_p(images_dest_dir) 

Dir.glob(posts_dir).reverse_each do |file|
  basename = File.basename(file, '.html')
  
  next if basename.start_with?('draft_')

  html = File.read(file)
  doc = Nokogiri::HTML(html)

  title_node = doc.at_css('h1.p-name') || doc.at_css('h1')
  title = title_node ? title_node.text.strip : basename
  
  time_node = doc.at_css('time.dt-published')
  if time_node && time_node['datetime']
    date = DateTime.parse(time_node['datetime'])
  else
    date = DateTime.now 
  end

  content_node = doc.at_css('section[data-field="body"]')
  next unless content_node 

  content_node.at_css('h1')&.remove
  next if content_node.text.strip.length < 150

  clean_slug = basename.gsub(/-[a-z0-9]+$/, '') 
  jekyll_filename = "_posts/#{date.strftime('%Y-%m-%d')}-#{clean_slug}.md"

  # Image Tracking Variables
  cover_image = nil
  first_image = nil

  content_node.css('img').each_with_index do |img, index|
    src = img['src']
    
    if src && src.start_with?('http')
      begin
        # 1. Smarter Extension Detection
        ext = File.extname(URI.parse(src).path)
        if src.include?('format:webp')
          ext = '.webp'
        elsif src.include?('format:png')
          ext = '.png'
        elsif ext.empty?
          ext = '.jpg'
        end
        
        local_img_name = "#{date.strftime('%Y-%m-%d')}-#{clean_slug}-#{index}#{ext}"
        local_img_path = File.join(images_dest_dir, local_img_name)

        # 2. Prevent 403s and 0-byte files by mimicking a real browser
        image_data = URI.open(src, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)").read
        
        File.open(local_img_path, 'wb') do |saved_file|
          saved_file.write(image_data)
        end

        # Identify the cover image
        if img['data-is-featured'] == 'true'
          cover_image = "/#{local_img_path}"
        end
        first_image ||= "/#{local_img_path}" 

        img['src'] = "/#{local_img_path}"
        
      rescue => e
        puts "  [Warning] Failed to download image in #{title}: #{e.message}"
      end
    end
  end

  # Fallback: If no featured image is tagged, use the first image in the post
  cover_image ||= first_image

  markdown = ReverseMarkdown.convert(
    content_node.to_html, 
    github_flavored: true,
    unknown_tags: :pass_through
  )

  # Build the Frontmatter dynamically
  frontmatter = "---\n"
  frontmatter += "title: \"#{title.gsub('"', '\"')}\"\n"
  frontmatter += "date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}\n"
  frontmatter += "permalink: /#{basename}\n"
  
  if cover_image
    frontmatter += "header:\n"
    frontmatter += "  teaser: #{cover_image}\n"
  end

  frontmatter += "tags:\n  - \n"
  frontmatter += "categories:\n  - \n"
  frontmatter += "---"

  File.write(jekyll_filename, frontmatter + "\n\n" + markdown)
  puts "Converted: #{title}"
end

puts "Migration complete! Images downloaded and frontmatter optimized."