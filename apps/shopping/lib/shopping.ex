defmodule ElixirStore.Shopping do
  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    start_session_supervisor()
    start_database()
  end

  def start_session_supervisor do
    session_worker = worker(ElixirStore.Shopping.Session, [])
    Supervisor.start_link([session_worker], strategy: :simple_one_for_one, name: ElixirStore.SessionSupervisor)
  end

  def start_database do
    db_worker = worker(ElixirStore.Shopping.Db, [database: "elixirstore"])
    Supervisor.start_link([db_worker], strategy: :one_for_one)
  end

  def start_session(key: key) when is_binary(key), do: raise "Please use an atom key"
  def start_session(key: key) when is_atom(key) do
    Supervisor.start_child(ElixirStore.SessionSupervisor, [%{key: key}])
  end
end
