defmodule CarPoolingWeb.View do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.View,
        root: "lib/car_pooling_web/templates",
        namespace: CarPoolingWeb
    end
  end
end
