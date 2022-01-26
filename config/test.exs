import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bombermonster_web, BombermonsterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/ThpDppSOcj4dNsYfgzy+Zaw8FwL/aTDm8+vdbBfI3An7xlhbR67MqUfdWEMEjB7",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :bombermonster, Bombermonster.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
