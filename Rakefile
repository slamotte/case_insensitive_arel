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
  gem.name = "case_insensitive_arel"
  gem.homepage = "http://github.com/slamotte/case_insensitive_arel"
  gem.license = "MIT"
  gem.summary = %Q{Forces Arel queries to be case-insensitive}
  gem.description = %Q{If you're using Oracle or another DBMS that has case-insensitive collation sequences, and you don't want to litter your database access code with case conversions, this gem is for you.}
  gem.email = "steve@lexor.ca"
  gem.authors = ["Steve Lamotte"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'arel', '>= 2.2.1'
  gem.add_runtime_dependency 'activesupport', '>= 3.1.0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "case_insensitive_arel #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options += %w(--line-numbers --inline-source --accessor cattr_accessor)
end
