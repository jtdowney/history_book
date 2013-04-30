require 'spec_helper'

describe HistoryBook::Memory::Store do
  subject(:store) { HistoryBook::Memory::Store.new }

  before(:each) do
    HistoryBook::Memory::Store.reset!
  end

  it_behaves_like 'a storage driver'

  describe 'load_events' do
    it 'should return events saved across instances' do
      event1 = HistoryBook::Event.new(:foobar, :foo => 1)
      event2 = HistoryBook::Event.new(:foobar, :foo => 2)

      store1 = HistoryBook::Memory::Store.new
      store1.store_events('test_id', event1)

      store2 = HistoryBook::Memory::Store.new
      store2.store_events('test_id', event2)
      store2.load_events('test_id').should == [event1, event2]
    end
  end
end
