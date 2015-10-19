require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)
task default: [:rubocop, :spec]

desc "Run RuboCop on the lib directory"
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ["lib/**/*.rb", "spec/**/*.rb"]
  task.formatters = ["files"]
  task.fail_on_error = true
end
