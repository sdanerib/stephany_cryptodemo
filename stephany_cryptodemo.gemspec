
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stephany_cryptodemo/version"

Gem::Specification.new do |spec|
  spec.name          = "stephany_cryptodemo"
  spec.version       = StephanyCryptodemo::VERSION
  spec.authors       = ["Stephany Daneri Beltran"]
  spec.email         = ["sdanerib@gmail.com"]

  spec.summary       = %q{The most basic implementation of a crypto currency.}
  spec.description   = %q{[Ruby on Rails Training] Cryptodemo will allow us to perform safe transactions keeping an immutable chain state.}
  spec.homepage      = "https://github.com/sdanerib/stephany_cryptodemo"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16.1"
end
