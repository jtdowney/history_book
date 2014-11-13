require 'transit'

require 'history_book/event'
require 'history_book/stream'
require 'history_book/version'

module HistoryBook
  class << self
    attr_reader :config
  end

  Drivers = {
    'memory' => 'Memory',
    'sequel' => 'Sequel',
  }

  def self.configure(driver)
    driver_klass = _load_driver(driver)

    unless @config.instance_of?(driver_klass)
      @config = driver_klass.new
    end

    if block_given?
      yield @config
    end
  end

  def self.open(id)
    store = config.create_store
    yield HistoryBook::Stream.new(id, store)
  end

  def self._load_driver(driver)
    path = "history_book/#{driver}/configuration"
    require path
    klass_name = Drivers.fetch(driver.to_s)
    HistoryBook.const_get(klass_name).const_get(:Configuration)
  rescue LoadError
    raise "Unable to load #{driver} driver for history_book"
  end
end
