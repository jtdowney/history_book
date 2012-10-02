module HistoryBook
  class Event
    attr_reader :type, :data

    def initialize(type, data = {})
      @type = type
      @data = data.with_indifferent_access
    end

    def ==(other)
      self.type == other.type && self.data == other.data
    end
  end
end
