# frozen_string_literal: true

GEM_NAME = 'cry_bug'
VERSION = '0.1.0'

desc 'Lint gem'
task :lint do
  `rubocop -A`
end

# Build a source gem; the native extension compiles during gem installation.
desc 'Package an installable source gem in pkg/'
task gem: [:lint] do
  FileUtils.rm_rf('pkg')
  sh 'gem', 'build', "#{GEM_NAME}.gemspec"
  FileUtils.mkdir_p('pkg')
  FileUtils.mv("#{GEM_NAME}-#{VERSION}.gem", 'pkg/')
end
