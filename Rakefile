require 'rubygems'
require 'rake'
require 'rspec'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "verity"
    gem.summary = %Q{verity is a DSL for writing validations for arbitrary objects}
    gem.email = "joe@joegeldart.com"
    gem.homepage = "http://github.com/jgeldart/verity"
    gem.authors = ["Joe Geldart"]
    gem.files = FileList['lib/**/*.rb', 'doc/**/*', '[A-Z]*', 'spec/**/*', 'vendor/**/*'].to_a
    gem.has_rdoc = false
    gem.required_ruby_version = ">= 1.8.7"
    gem.add_development_dependency("rspec", ">= 1.3.0")
    gem.add_development_dependency("yard" , ">= 0.5.3")
    gem.add_development_dependency("yardstick",">= 0.1.0")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:test) do |t|
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end

desc "Create yardocs according to .yardopts file"
task :yardoc do
  `yardoc`
end

# Measure documentation coverage

desc "Suggest improvements for the documentation"
task :yardstick do
  `yardstick 'lib/**/*.rb' > tmp/yardstick.txt`
end

task :spec => :test
task :default => :test
