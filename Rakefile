
require 'bundler/setup'
require 'stove/rake_task'

Stove::RakeTask.new

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  require 'cookstyle'
  require 'rubocop/rake_task'
  desc 'Run Cookstyle'
  RuboCop::RakeTask.new(:cookstyle) do |task|
    task.options << '--display-cop-names'
  end
end

desc 'Run all style checks'
task style: ['style:cookstyle', 'style:ruby']

require 'kitchen'
desc 'Run Test Kitchen integration tests'
task :integration do
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end

require 'rspec/core/rake_task'
desc 'Run ChefSpec unit tests'
RSpec::Core::RakeTask.new(:spec) do |t, _args|
  t.rspec_opts = 'spec'
end

# The default rake task should just run it all
task default: %w(style spec integration)

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
