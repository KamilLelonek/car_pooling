defmodule CarPooling.Application do
  use Application

  def start(_type, _args),
    do: Supervisor.start_link(children(), opts())

  defp children do
    [
      CarPooling.Domain.Repo,
      CarPoolingWeb.Endpoint
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: CarPooling.Supervisor
    ]
  end

  def config_change(changed, _new, removed) do
    CarPoolingWeb.Endpoint.config_change(changed, removed)

    :ok
  end
end
