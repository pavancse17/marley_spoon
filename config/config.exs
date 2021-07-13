# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :marely,
  ecto_repos: [Marely.Repo],
  space_id: "kk2bw5ojx476",
  access_token: "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c",
  environment: "master"

# Configures the endpoint
config :marely, MarelyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eYW9/LgKx9rs8QdDqMrJ7W4fvWDYStQy6P9AEvZ/tkgKzjX5PDfuoGp2WU8gx6RX",
  render_errors: [view: MarelyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Marely.PubSub,
  live_view: [signing_salt: "py+zUI2g"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
