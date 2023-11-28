# frozen_string_literal: true

module ::DeprecationCollector
  class CollectorController < ::ApplicationController
    requires_plugin PLUGIN_NAME
    skip_before_action :check_xhr, :verify_authenticity_token

    LOGS_PER_10_SECONDS = 2

    def log
      RateLimiter.new(
        nil,
        "deprecation_collector_report_#{current_user&.id || request.client_ip}",
        LOGS_PER_10_SECONDS,
        10,
      ).performed!

      begin
        reported_data = JSON.parse(params.require("data"))
      rescue JSON::ParserError
        raise Discourse::InvalidParameters.new("Cannot parse JSON")
      end

      if reported_data.count > 20
        raise Discourse::InvalidParameters.new("Too many deprecations reported")
      end

      reported_data.each do |key, value|
        next if !value.is_a?(Integer)

        if !DeprecationCollector::List.include?(key)
          # We only collect data for a bound set of deprecation-ids so that clients
          # can't inflate our prometheus metrics by sending bogus data.
          key = "_other"
        end

        add_to_counter(key, 1)
      end

      render json: success_json
    end

    private

    def add_to_counter(name, value)
      metric = DiscoursePrometheus::InternalMetric::Custom.new
      metric.type = "Counter"
      metric.labels = { db: RailsMultisite::ConnectionManagement.current_db, deprecation_id: name }
      metric.name = "js_deprecation_count"
      metric.description = "js deprecations reported by clients"
      metric.value = value
      $prometheus_client.send_json(metric.to_h)
    end
  end
end
