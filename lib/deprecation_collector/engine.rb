# frozen_string_literal: true

module ::DeprecationCollector
  class Engine < ::Rails::Engine
    engine_name PLUGIN_NAME
    isolate_namespace DeprecationCollector
    config.autoload_paths << File.join(config.root, "lib")
  end
end
