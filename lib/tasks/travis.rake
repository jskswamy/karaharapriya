namespace :travis do
  desc 'rake task for running rspec and cucumber in travis ci'
  task :run do
    #system('sh -e /etc/init.d/xvfb start')
    ["rspec spec"].each do |cmd|
      puts "Starting to run #{cmd}..."
      system("export DISPLAY=:99.0 && bundle exec #{cmd}")
      raise "#{cmd} failed!" unless $?.exitstatus == 0
    end
  end
end
