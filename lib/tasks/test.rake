namespace :test do
  desc "Say hello"
  task say_hello: :environment do
    puts "Hello World"
  end
end
