# frozen_string_literal: true

DeprecationCollector::Engine.routes.draw do
  post "log" => "collector#log"
  get "log" => "collector#log"
end

Discourse::Application.routes.draw do
  mount ::DeprecationCollector::Engine, at: "deprecation-collector"
end
