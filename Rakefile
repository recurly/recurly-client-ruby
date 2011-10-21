require 'rake/testtask'

Rake::TestTask.new :spec do |t|
  t.libs << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
  t.warning = true
end

task :default => :spec
