# frozen_string_literal: true

# name: discourse-deprecation-collector
# about: Collects metrics for JS deprecations
# version: 1.0
# authors: Discourse

enabled_site_setting :deprecation_collector_enabled

module ::DeprecationCollector
  PLUGIN_NAME = "discourse-deprecation-collector"
end

require_relative "lib/deprecation_collector/engine"
