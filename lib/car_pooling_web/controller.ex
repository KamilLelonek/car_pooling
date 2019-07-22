defmodule CarPoolingWeb.Controller do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller,
        namespace: CarPoolingWeb
    end
  end
end
