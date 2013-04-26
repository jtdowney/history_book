# HistoryBook [![Build Status](https://secure.travis-ci.org/jtdowney/history_book.png?branch=master)](http://travis-ci.org/jtdowney/history_book)

HistoryBook is a ruby implementation of the [event sourcing](http://martinfowler.com/eaaDev/EventSourcing.html) pattern.

This library provides an interface for event sourcing over a pluggable back end data store. Currently it supports the [Sequel gem](http://sequel.rubyforge.org/) and its data stores as well as an in-memory data store for testing.

## Usage

To run the example below you will need to install (or place in your Gemfile) both the sequel gem and the pg gem.

```ruby
HistoryBook.configure(:sequel) do |config|
  config.connection_string = 'postgres://localhost/history_book'
end

HistoryBook.open('test_id') do |stream|
  stream << HistoryBook::Event.new(:customer_created, :name => 'Joe Tester', :address => '100 West Washington')
  stream.commit
end

HistoryBook.open('test_id') do |stream|
  stream.events.each do |event|
    puts "Playback event #{event.type} with #{event.data.inspect}"
  end
end
```
