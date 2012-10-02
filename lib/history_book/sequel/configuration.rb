require 'sequel'
require 'history_book/sequel/store'

module HistoryBook
  module Sequel
    class Configuration
      attr_accessor :connection_string

      def create_store
        db = ::Sequel.connect(connection_string)
        HistoryBook::Sequel::Store.new(db)
      end
    end
  end
end
