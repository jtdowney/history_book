require 'spec_helper'

describe HistoryBook::Sequel::Store do
  around(:each) do |example|
    @db = Sequel.sqlite(':memory:')
    @store = HistoryBook::Sequel::Store.new(@db)
    @db.transaction do
      example.run
    end
  end

  it_behaves_like 'a storage driver'

  describe 'initialize' do
    it 'should create an events table' do
      @db.drop_table?(:events)
      HistoryBook::Sequel::Store.new(@db)
      @db.table_exists?(:events).should be_true
    end
  end
end
