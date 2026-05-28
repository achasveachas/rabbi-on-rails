require 'yaml'
require 'date'

def parse_frontmatter(path)
  content = File.read(path)
  match = content.match(/\A---\s*\r?\n(.*?)\r?\n---\s*\r?\n/m)
  return nil unless match

  YAML.safe_load(match[1], permitted_classes: [Date, Time, DateTime]) || {}
rescue StandardError
  nil
end

posts_by_slug = {}

# Some Dev.to links use old slugs that were later changed by Dev.to.
# Map legacy slugs to the current imported post slugs.
slug_aliases = {
  'creating-my-first-twitter-bot-1kj4' => 'creating-my-first-twitter-bot-b5e0da5c8cbb',
  'introducing-86daysofcode-2ga9' => '100days0fcode-c32a5a1e1ef1'
}

Dir.glob('_posts/*.md').sort.each do |path|
  fm = parse_frontmatter(path)
  next unless fm

  permalink = fm['permalink']
  title = fm['title']
  next unless permalink && title

  slug = permalink.sub(%r{^/}, '').sub(%r{/$}, '')
  next if slug.empty?

  posts_by_slug[slug] = { 'title' => title, 'permalink' => permalink }
end

changed_files = []
updated_links = 0

link_regex = /\[([^\]]+)\]\((https?:\/\/dev\.to\/yechielk\/([^\)\/?#]+)[^\)]*)\)/

Dir.glob('_posts/*.md').sort.each do |path|
  original = File.read(path)
  file_updates = 0

  updated = original.gsub(link_regex) do
    label = Regexp.last_match(1)
    url = Regexp.last_match(2)
    slug = Regexp.last_match(3)
    slug = slug_aliases.fetch(slug, slug)

    local_post = posts_by_slug[slug]
    next Regexp.last_match(0) unless local_post

    new_label = (label == url) ? local_post['title'] : label
    file_updates += 1
    "[#{new_label}](#{local_post['permalink']})"
  end

  next if updated == original

  File.write(path, updated)
  changed_files << path
  updated_links += file_updates
end

puts "Rewrote #{updated_links} internal Dev.to link(s) across #{changed_files.size} file(s)"
changed_files.each { |path| puts path }