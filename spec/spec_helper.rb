require 'history_book'
require 'history_book/memory/configuration'
require 'history_book/sequel/configuration'

support_dir = File.expand_path('../support', __FILE__)
Dir.glob("#{support_dir}/**/*.rb") do |file|
  require file
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'
end
