require 'rubygems'
require 'rake'
require 'spec'
require 'metric_fu'

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
    gem.has_yardoc = true
    gem.required_ruby_version = ">= 1.8.7"
    gem.add_development_dependency("rspec", ">= 1.3.0")
    gem.add_development_dependency("yard" , ">= 0.5.3")
    gem.add_development_dependency("yardstick",">= 0.1.0")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:test) do |t|
  t.spec_opts = ['--options', "spec/spec.opts"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = ['--exclude','spec,gems']
end

MetricFu::Configuration.run do |config|
  #define which metrics you want to use
  config.metrics  = [:churn, :saikuro, :flog, :flay]
  config.graphs   = []
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
