require 'history_book/memory/store'

module HistoryBook
  module Memory
    class Configuration
      def create_store
        HistoryBook::Memory::Store.new
      end
    end
  end
end
