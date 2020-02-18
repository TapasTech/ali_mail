lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ali_mail/version"

Gem::Specification.new do |spec|
  spec.name          = "ali_mail"
  spec.version       = AliMail::VERSION
  spec.authors       = ["王广星"]
  spec.email         = ["wangguangxing@tapas.com"]

  spec.summary       = "Aliyun Mail service ruby SDK"
  spec.description   = "Aliyun Mail service ruby SDK"
  spec.homepage      = "https://github.com/veetase/ali_mail"
  spec.license       = "MIT"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/veetase/ali_mail"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
