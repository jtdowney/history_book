require 'spec_helper'

describe HistoryBook::Sequel::Configuration do
  describe 'create_store' do
    it 'should return a memory store' do
      config = HistoryBook::Sequel::Configuration.new
      config.connection_string = 'sqlite:/'
      config.create_store.should be_instance_of(HistoryBook::Sequel::Store)
    end
  end
end
