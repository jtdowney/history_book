# -*- encoding: utf-8 -*-
$:.unshift File.expand_path('../lib', __FILE__)
require 'history_book/version'

Gem::Specification.new do |s|
  s.name        = 'history_book'
  s.version     = HistoryBook::VERSION
  s.authors     = ['John Downey']
  s.email       = ['jdowney@gmail.com']
  s.homepage    = 'http://github.com/jtdowney/history_book'
  s.license     = 'MIT'
  s.summary     = %q{HistoryBook is a ruby implementation of the event sourcing pattern.}
  s.description = %q{This library provides an interface for event sourcing over a pluggable back end data store. Currently it supports the Sequel gem and its data stores as well as an in-memory data store for testing.}

  s.files        = Dir.glob('{lib,spec}/**/*.rb') + %w{README.md LICENSE}
  s.test_files   = Dir.glob('spec/**/*')
  s.require_path = 'lib'

  s.add_dependency 'transit-ruby', '~> 0.8'

  s.add_development_dependency 'rspec', '2.14.1'
  s.add_development_dependency 'rake', '10.3.2'
  s.add_development_dependency 'sequel', '3.46.0'
  s.add_development_dependency 'sqlite3', '1.3.10'
end
