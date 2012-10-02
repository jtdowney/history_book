shared_examples 'a storage driver' do
  describe 'load_events' do
    it 'should be empty when no events are stored' do
      @store.load_events('empty_id').should be_empty
    end

    it 'should return previously stored events' do
      event = HistoryBook::Event.new(:foobar, :foo => 1)
      @store.store_events('test_id', event)
      @store.load_events('test_id').should == [event]
    end

    it 'should return all events up to a specified sequence' do
      event1 = HistoryBook::Event.new(:foobar, :foo => 1)
      event2 = HistoryBook::Event.new(:foobar, :foo => 2)
      @store.store_events('test_id', event1)
      @store.store_events('test_id', event2)
      @store.load_events('test_id', :to => 1).should == [event1]
    end

    it 'should return all events since a specified sequence' do
      event1 = HistoryBook::Event.new(:foobar, :foo => 1)
      event2 = HistoryBook::Event.new(:foobar, :foo => 2)
      @store.store_events('test_id', event1)
      @store.store_events('test_id', event2)
      @store.load_events('test_id', :from => 2).should == [event2]
    end

    it 'should return all events in a specified range' do
      event1 = HistoryBook::Event.new(:foobar, :foo => 1)
      event2 = HistoryBook::Event.new(:foobar, :foo => 2)
      event3 = HistoryBook::Event.new(:foobar, :foo => 3)
      event4 = HistoryBook::Event.new(:foobar, :foo => 4)
      @store.store_events('test_id', [event1, event2, event3, event4])
      @store.load_events('test_id', :from => 2, :to => 3).should == [event2, event3]
    end
  end

  describe 'store_events' do
    it 'should store events in order' do
      event1 = HistoryBook::Event.new(:foobar, :foo => 1)
      event2 = HistoryBook::Event.new(:foobar, :foo => 2)
      @store.store_events('test_id', event1)
      @store.store_events('test_id', event2)
      @store.load_events('test_id').should == [event1, event2]
    end

    it 'should store an array of events' do
      event1 = HistoryBook::Event.new(:foobar, :foo => 1)
      event2 = HistoryBook::Event.new(:foobar, :foo => 2)
      @store.store_events('test_id', [event1, event2])
      @store.load_events('test_id').should == [event1, event2]
    end

    it 'should store events by id' do
      event1 = HistoryBook::Event.new(:foobar, :foo => 1)
      event2 = HistoryBook::Event.new(:foobar, :foo => 2)
      @store.store_events('test_id1', event1)
      @store.store_events('test_id2', event2)
      @store.load_events('test_id1').should == [event1]
    end
  end
end
