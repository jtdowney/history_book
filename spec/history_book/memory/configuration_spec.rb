require 'spec_helper'

describe HistoryBook::Memory::Configuration do
  describe 'create_store' do
    it 'should return a memory store' do
      config = HistoryBook::Memory::Configuration.new
      config.create_store.should be_instance_of(HistoryBook::Memory::Store)
    end
  end
end
