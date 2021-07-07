require 'thor'

class Post < Thor
  desc 'create TITLE', 'Create a new jekyll post'

  method_option :date, aliases: '-d',
                       default: Time.now.strftime('%Y-%m-%d'),
                       desc: "Date for the post format ('2021-12-26')"
  def create(*title)
    post_title = title.join("-").downcase
    filename = "_posts/#{options[:date]}-#{post_title}.md"

    if File.exist?(filename)
      abort("#{filename} already exists!")
    end

    open(filename, 'w') do |post|
      post.puts '---'
      post.puts 'layout: post'
      post.puts "title: \"#{post_title.gsub(/&/,'&amp;')}\""
      post.puts "date: \"#{options[:date]}\""
      post.puts 'category:'
      post.puts 'tags: '
      post.puts '---'
    end

    puts "New post created: #{filename}"
  end
end
