defmodule Foodtruck.Boundary.TruckStore do
  @moduledoc """
  TruckStore is an Agent acting as an ad hoc DB store for trucks.
  It's started by the supervisor tree and queried on each request
  """
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @doc """
  Gets the list of trucks out of the store.
  For performance reasons, we pull the entire list and filter it outside of the agent.
  We don't want to block access to the agent based on some long running function.
  """
  def list do
    Agent.get(__MODULE__, & &1)
  end
end
