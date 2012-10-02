module HistoryBook
  module Memory
    class Store
      @@events = {}
      @@events_lock = Mutex.new

      def load_events(id, options = {})
        options = {:from => 1, :to => nil}.merge(options)
        from, to = options.values_at(:from, :to)

        events = @@events.fetch(id, [])
        _filter_events(events, from, to)
      end

      def store_events(id, new_events)
        new_events = Array(new_events)
        @@events_lock.synchronize do
          @@events[id] ||= []
          @@events[id].concat(new_events)
        end
      end

      def _filter_events(events, from, to)
        if to
          events = events.reject.with_index { |e, i| i > to - 1 }
        end

        events.select.with_index { |e, i| i >= from - 1 }
      end
    end
  end
end
