# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
require "#{File.dirname(__FILE__)}/lib/devise_user_metering/version"
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "devise_user_metering"
  gem.homepage = "http://github.com/MustWin/devise_user_metering"
  gem.license = "MIT"
  gem.summary = %Q{Add methods to devise User models that account for active time during a month. Useful for SAAS billings}
  gem.description = %Q{Add methods to devise User models that account for active time during a month. Useful for SAAS billings}
  gem.email = "we@mustwin.com"
  gem.authors = ["Mike Ihbe"]
  gem.version = DeviseUserMetering::Version::VERSION
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "devise_user_metering #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
