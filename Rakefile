require 'rubygems'
require 'rake'
require 'rake/testtask'

require 'bundler'
Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.libs << "."
  t.test_files = FileList['test/test*.rb']
end

task :default => :test

