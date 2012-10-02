require 'spec_helper'

describe HistoryBook::Stream do
  before(:each) do
    HistoryBook::Memory::Store.reset!
    @store = HistoryBook::Memory::Store.new

    @stream = HistoryBook::Stream.new('test_id', @store)
  end

  describe '<<' do
    it 'should append uncommitted events' do
      event = HistoryBook::Event.new(:foobar, :foo => 1)
      @stream << event
      @stream.uncommitted_events.should == [event]
    end
  end

  describe 'commit' do
    it 'should commit all uncommitted events' do
      event = HistoryBook::Event.new(:foobar, :foo => 1)
      @stream << event
      @stream.commit
      @stream.events.should == [event]
      @stream.uncommitted_events.should be_empty
    end
  end

  describe 'events' do
    it 'should be empty if there are no prior events' do
      @stream.events.should be_empty
    end

    it 'should be populated with existing events' do
      event = HistoryBook::Event.new(:foobar, :foo => 1)
      @stream << event
      @stream.commit
      @stream = HistoryBook::Stream.new('test_id', @store)
      @stream.events.should == [event]
    end
  end

  describe 'uncommitted_events' do
    it 'should be empty to start' do
      @stream.uncommitted_events.should be_empty
    end
  end
end
