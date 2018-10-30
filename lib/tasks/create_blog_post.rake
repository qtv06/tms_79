namespace :create_blog_post do
  desc "Create and saving blog post"
  task run: :environment do
    generate_default_blog_post
    save
  end

  def generate_default_blog_post
    puts "Generating default blog post"
  end

  def save
    puts "Save default blog post"
  end
end
