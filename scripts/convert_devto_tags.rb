require 'cgi'

def gist_embed_html(gist_url, file_name = nil)
  js_url = "#{gist_url}.js"
  js_url += "?file=#{CGI.escape(file_name)}" if file_name && !file_name.empty?

  [
    "<script src=\"#{js_url}\"></script>",
    "<noscript><a href=\"#{gist_url}\">View gist</a></noscript>"
  ].join("\n")
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
    [
      "<blockquote class=\"twitter-tweet\"><a href=\"https://twitter.com/i/web/status/#{tweet_id}\">Tweet</a></blockquote>",
      "<script async src=\"https://platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>"
    ].join("\n")
  end

  converted
end

changed = []

Dir.glob('_posts/*.md').sort.each do |path|
  original = File.read(path)
  converted = convert_devto_liquid_tags(original)
  next if converted == original

  File.write(path, converted)
  changed << path
end

puts "Updated #{changed.size} post(s)"
changed.each { |path| puts path }