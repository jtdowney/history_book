require 'spec_helper'

describe HistoryBook::Sequel::Store do
  around(:each) do |example|
    @db = Sequel.sqlite(':memory:')
    @store = HistoryBook::Sequel::Store.new(@db, :events)
    @db.transaction do
      example.run
    end
  end

  it_behaves_like 'a storage driver'

  describe 'initialize' do
    it 'should create an events table' do
      @db.drop_table?(:events)
      HistoryBook::Sequel::Store.new(@db, :events)
      @db.table_exists?(:events).should be_true
    end

    it 'should use the configured table name' do
      @db.drop_table?(:events2)
      HistoryBook::Sequel::Store.new(@db, :events2)
      @db.table_exists?(:events2).should be_true
    end
  end
end
