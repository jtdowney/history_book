require 'spec_helper'

describe HistoryBook do
  before(:each) do
    HistoryBook.configure(:memory)
    HistoryBook::Memory::Store.reset!
  end

  describe 'self.configure' do
    it 'should create a driver specific configuration' do
      HistoryBook.config.should be_instance_of(HistoryBook::Memory::Configuration)
    end

    it 'should yield a configuration object' do
      yielded = false
      HistoryBook.configure(:memory) do |config|
        yielded = true
        config.should == HistoryBook.config
      end
      yielded.should be_true
    end

    it 'should not overwrite an existing configuration object of the same type' do
      old_config = HistoryBook.config
      HistoryBook.configure(:memory)
      HistoryBook.config.object_id.should == old_config.object_id
    end

    it 'should overwrite an existing configuration object not of the same type' do
      old_config = HistoryBook.config
      HistoryBook.configure(:sequel)
      HistoryBook.config.object_id.should_not == old_config.object_id
    end

    it 'should raise an error if driver does not exist' do
      expect do
        HistoryBook.configure(:asdf)
      end.to raise_error("Unable to load asdf driver for history_book")
    end
  end

  describe 'self.open' do
    it 'should open an event stream for reading and writting' do
      event = HistoryBook::Event.new(:something_happened, :foo => 'bar')
      HistoryBook.open('test_id') do |stream|
        stream << event
        stream.commit
      end

      HistoryBook.open('test_id') do |stream|
        stream.events.should == [event]
      end
    end

    it 'should yield an event stream' do
      yielded = false
      HistoryBook.open('test_id') do |stream|
        yielded = true
        stream.should_not be_nil
      end
      yielded.should be_true
    end
  end
end
