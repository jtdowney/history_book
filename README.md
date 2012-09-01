# HistoryBook

HistoryBook is a ruby implementation of the [event sourcing](http://martinfowler.com/eaaDev/EventSourcing.html) pattern.

## Usage

```ruby
HistoryBook.configure(:memory) do |config|
  config.environment = :development
end

HistoryBook.open('test_id') do |stream|
  stream << HistoryBook::Event.new(:customer_created, :name => 'Joe Tester', :address => '100 West Washington')
  stream.commit
end

HistoryBook.open('test_id') do |stream|
  stream.events.each do |event|
    puts "Playback event #{event.id} with #{event.data.inspect}"
  end
end
```