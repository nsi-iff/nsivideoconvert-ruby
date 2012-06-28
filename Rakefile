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
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "nsivideoconvert"
  gem.homepage = "http://github.com/nsi-iff/nsivideoconvert-ruby.git"
  gem.license = "MIT"
  gem.summary = %Q{A simple gem to access a nsi.videoconvert node}
  gem.description = %Q{A simple gem to access a nsi.videogconvert node}
  gem.email = "d.camata@gmail.com"
  gem.authors = ["Douglas Camata"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.rspec_opts = "--color --format nested"
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
