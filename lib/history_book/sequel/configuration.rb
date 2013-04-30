require 'sequel'
require 'history_book/sequel/store'

module HistoryBook
  module Sequel
    class Configuration
      attr_accessor :connection_string, :events_table

      def initialize
        @connection_string = 'sqlite:/'
        @events_table = :events
      end

      def create_store
        db = ::Sequel.connect(connection_string)
        HistoryBook::Sequel::Store.new(db, events_table)
      end
    end
  end
end
