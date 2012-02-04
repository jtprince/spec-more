require 'rubygems'
require 'rake'
require 'jeweler'
require 'rake/rdoctask'


Jeweler::Tasks.new do |gem|
  gem.name = "spec-more"
  gem.summary = %Q{very terse syntax for testing/specing ala Test::More}
  gem.email = "jtprince@gmail.com"
  gem.homepage = "http://github.com/jtprince/spec-more"
  gem.authors = ["John T. Prince"]
  gem.add_development_dependency("bacon")
  gem.add_development_dependency("rspec")
end

require 'rake/testtask'
Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

task :default => :spec

Rake::RDocTask.new do |rdoc|
  version = IO.readlines('VERSION').first.chomp
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "spec-more #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :build => :gemspec
