require "bundler/gem_tasks"
require 'rake/testtask'
require 'rake/version_task'

Rake::VersionTask.new do |task|
  task.with_git_tag = true
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = "test/*_test.rb"
end
