defmodule Marely.Repo do
  use Ecto.Repo,
    otp_app: :marely,
    adapter: Ecto.Adapters.Postgres
end
