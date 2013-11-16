require 'active_support/dependencies'

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'database'
require "database_cleaner"
require "factory_girl"
require 'webmock'
require 'pry'

$:.unshift File.expand_path("../../lib/niconico-ranking-crawler", __FILE__)
$:.unshift File.expand_path("../../lib", __FILE__)
$:.unshift File.expand_path("../../config", __FILE__)

ActiveSupport::Dependencies.autoload_paths << "lib/niconico-ranking-crawler"
ActiveSupport::Dependencies.autoload_paths << "lib"
ActiveSupport::Dependencies.autoload_paths << "config"

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before(:all) do
    FactoryGirl.reload
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
