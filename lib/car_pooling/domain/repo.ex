defmodule CarPooling.Domain.Repo do
  use Ecto.Repo,
    otp_app: :car_pooling,
    adapter: Ecto.Adapters.Postgres

  def init(_, opts),
    do: {:ok, opts(load_from_system_env?(), opts)}

  defp opts(true, opts) do
    Keyword.merge(
      opts,
      system_config()
    )
  end

  defp opts(_, opts), do: opts

  defp system_config do
    [
      url: System.get_env("DB_URL"),
      pool_size: "DB_POOL_SIZE" |> System.get_env() |> String.to_integer()
    ]
  end

  defp load_from_system_env?, do: Application.get_env(:car_pooling, CarPooling.Domain.Repo)
end
