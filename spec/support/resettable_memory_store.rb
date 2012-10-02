module HistoryBook
  module Memory
    class Store
      def self.reset!
        @@events_lock.synchronize do
          @@events = {}
        end
      end
    end
  end
end
