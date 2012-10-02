require 'active_support/core_ext/hash'
require 'active_support/inflector'
require 'multi_json'

require 'history_book/event'
require 'history_book/stream'
require 'history_book/version'

module HistoryBook
  class << self
    attr_reader :config
  end

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
    path.classify.constantize
  rescue LoadError
    raise "Unable to load #{driver} driver for history_book"
  end
end
