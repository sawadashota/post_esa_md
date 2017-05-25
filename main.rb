require 'esa'
require 'optparse'

def set_client
  @options = {}
  opt      = OptionParser.new
  opt.on('-n', '--team ITEM', 'Set esa team name.') { |v| @options[:team] = v }
  opt.on('-t', '--token ITEM', 'Set esa access token.') { |v| @options[:token] = v }
  opt.parse(ARGV)
  @client = Esa::Client.new(
    access_token: @options[:token], current_team: @options[:team]
  )
end

def file_list
  Dir.glob("**/*.md")
end

def post(name, body_md)
  res = @client.create_post(
    name:     name,
    body_md:  body_md,
    wip:      false,
    category: 'Qiita::Team',
    user:     'esa_bot'
  )
  puts res.instance_variable_get('@raw_body')['message']
end

def parse_markdown(file_path)
  title = ''
  body  = ''
  File.open(file_path) do |file|
    file.read.split('\n').each do |text|
      title     = text.match(/Title\s+?:\s(.+?)\n/)[1]
      qiita_url = text.match(/Qiita\sURL\s+?:\s(.+?)\n/)[1]
      body      = text.match(/---\n\n([\s\S]+)/)[1]
      body << "\n## Copy From\n#{qiita_url}"
    end
  end
  [title, body]
end

def start_post
  file_list.each_with_index do |file_path, i|
    name, body = parse_markdown file_path
    post name, body
    puts "##{i}: Posted #{name}"
    sleep 12
  end
end

set_client
start_post