namespace :sass do
  desc 'updates stylesheets from their sass templates.'
  task :update => :environment do
    stylesheets_path = "public/stylesheets"
    files_to_update  = Dir["#{stylesheets_path}/**/*.scss", "#{stylesheets_path}/**/*.sass"].collect do |filename|
      [filename, File.join(stylesheets_path, File.basename(filename).gsub(/\.s[ac]ss$/, '.css'))]
    end

    Sass::Plugin.update_stylesheets files_to_update
  end
end
