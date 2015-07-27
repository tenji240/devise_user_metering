require 'simplecov'
require 'devise'
require 'pry-byebug'


module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_adapter 'test_frameworks'
end

ENV["COVERAGE"] && SimpleCov.start do
  add_filter "/.rvm/"
end
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'timecop'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'devise_user_metering'

class Test::Unit::TestCase
end

Timecop.safe_mode = true

class User
  include Devise::Models::UserMetering
  attr_accessor :activated_at, :deactivated_at, :rollover_active_duration, :active
  def save!; end
end

def new_user(opts)
  u = User.new
  opts.each do |k, v|
    u.send("#{k}=", v)
  end
  u
end

