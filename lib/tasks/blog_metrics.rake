namespace :blog_metrics do
  desc "Caculate and save blog metric"
  task :run do
    caculate_blog_metrics
    save
  end

  def caculate_blog_metrics
    puts "Caculate blog metrics"
  end

  def save
    puts "Save blog metrics"
  end
end
