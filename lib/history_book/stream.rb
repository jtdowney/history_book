module HistoryBook
  class Stream
    attr_reader :events, :uncommitted_events

    def initialize(id, store)
      @id = id
      @store = store
      @events = store.load_events(id)
      @uncommitted_events = []
    end

    def <<(event)
      @uncommitted_events << event
    end

    def commit
      @store.store_events(@id, @uncommitted_events)
      @events.concat(@uncommitted_events)
      @uncommitted_events = []
    end
  end
end
