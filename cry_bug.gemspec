# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'cry_bug'
  spec.version       = '0.1.0'
  spec.authors       = ['Ryan Oboril']
  spec.email         = ['tetsuo000@gmail.com']

  spec.summary       = "Pry, but don't cry - a fully featured pry stack"
  spec.homepage      = 'https://github.com/ryanoboril/cry_bug'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.bindir        = 'exe'
  spec.executables   = %w[cry ry]

  spec.add_dependency 'amazing_print', '~> 1.5'
  spec.add_dependency 'binding_of_caller', '~> 1.0'
  spec.add_dependency 'clipboard', '~> 1.4'
  spec.add_dependency 'pry', '~> 0.14'
  spec.add_dependency 'pry-byebug', '~> 3.10'
  spec.add_dependency 'pry-doc', '~> 1.3'
  spec.add_dependency 'pry-rescue', '~> 1.5'
  spec.add_dependency 'pry-stack_explorer', '~> 0.5'

  # spec.files = Dir.chdir(__dir__) do
  #   `git ls-files -z`.split("\u0000").reject { |f| f.match(%r{A(?:test|spec|features)/}) }
  # end
  spec.files = Dir['lib/**/*.rb', 'exe/*', 'README.md', 'cry_bug.gemspec'] if spec.files.empty?
end
