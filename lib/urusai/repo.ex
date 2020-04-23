defmodule Urusai.Repo do
  use Ecto.Repo,
    otp_app: :urusai,
    adapter: Ecto.Adapters.Postgres
end
