# frozen_string_literal: true

require 'yaml'
module DeprecationCollector
  DEPRECATION_IDS_FILE = "lib/deprecation_collector/deprecation-ids.yml"

  deprecations = YAML.load_file(DEPRECATION_IDS_FILE)
  List =
    (deprecations["ember_deprecation_ids"] || []).concat(
      deprecations["discourse_deprecation_ids"] || [],
    )
end
