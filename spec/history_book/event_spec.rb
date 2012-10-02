require 'spec_helper'

describe HistoryBook::Event do
  describe '==' do
    it 'should be false if nothing is equal' do
      event1 = HistoryBook::Event.new(:foo, :bar => 1)
      event2 = HistoryBook::Event.new(:bar, :foo => 2)
      event1.should_not == event2
    end

    it 'should be false if only type is the same' do
      event1 = HistoryBook::Event.new(:foo, :bar => 1)
      event2 = HistoryBook::Event.new(:foo, :foo => 2)
      event1.should_not == event2
    end

    it 'should be false if only data is the same' do
      event1 = HistoryBook::Event.new(:foo, :bar => 1)
      event2 = HistoryBook::Event.new(:bar, :bar => 1)
      event1.should_not == event2
    end

    it 'should be true if everything is the same' do
      event1 = HistoryBook::Event.new(:foo, :bar => 1)
      event2 = HistoryBook::Event.new(:foo, :bar => 1)
      event1.should == event2
    end
  end
end
