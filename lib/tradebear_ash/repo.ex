defmodule TradebearAsh.Repo do
  use Ecto.Repo,
    otp_app: :tradebear_ash,
    adapter: Ecto.Adapters.Postgres
end
