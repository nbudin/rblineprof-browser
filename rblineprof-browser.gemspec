# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rblineprof/browser/version'

Gem::Specification.new do |spec|
  spec.name          = "rblineprof-browser"
  spec.version       = Rblineprof::Browser::VERSION
  spec.authors       = ["Nat Budin"]
  spec.email         = ["natbudin@gmail.com"]

  spec.summary       = %q{An easy way to profile slow code in your Ruby console}
  spec.description   = %q{A console-based browser for rblineprof results}
  spec.homepage      = "https://github.com/nbudin/rblineprof-browser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "rblineprof"
  spec.add_dependency "highline"
  spec.add_dependency "pygments.rb"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
