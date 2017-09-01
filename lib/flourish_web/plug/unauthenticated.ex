defmodule FlourishWeb.Plug.Unauthenticated do
  def init(opts \\ %{}), do: Enum.into(opts, %{})

  def call(conn, opts) do
    key = Map.get(opts, :key, :default)

    case Guardian.Plug.claims(conn, key) do
      {:error, _} -> conn
      {:ok, _} ->
        Plug.Conn.halt(conn)
    end
  end
end
