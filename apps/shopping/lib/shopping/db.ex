defmodule ElixirStore.Shopping.Db do
  use Moebius.Database
  import Moebius.DocumentQuery
  alias ElixirStore.Shopping.Db

  def find_or_create_session(%{key: key, domain: domain} = args) do
    case db(:sessions) |> contains(key: key) |> Db.first do
      nil -> db(:sessions) |> Db.save(struct(%ElixirStore.Shopping.Session{}, args))
      found -> found
    end
  end

  def save_session(session) do
    db(:sessions) |> Db.save(session) 
  end
end
