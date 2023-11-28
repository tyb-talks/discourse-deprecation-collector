# **discourse-deprecation-collector** Plugin

This plugin will report JS deprecations to the server and increment prometheus metrics. It's designed to help hosting providers roll out breaking changes.

Requires the discourse-prometheus plugin to be installed.

Metric will be created with the name `discourse_js_deprecation_count`, and with two labels:

- `db` indicates the relevant site in a multisite cluster
- `deprecation_id` is the id of the discourse/ember deprecation

For a deprecation to be labelled correctly, its id needs to be added to the list in `lib/deprecation_collector/list`. Any unrecognised deprecations will be tracked against `id=_other`.
