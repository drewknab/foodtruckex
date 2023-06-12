defmodule Foodtruck.Core.TruckRequests do
  @moduledoc """
  Filters truck data in response to a users request.
  Limited to two options at present.
  """

  alias Foodtruck.Core.Truck

  @spec by_food(list(Truck.t()), list(String.t())) :: list(Truck.t)
  def by_food([%Truck{} | _tail] = trucks, items) when length(items) == 0 do
    trucks
  end

  def by_food([%Truck{} | _tail] = trucks, items) do
    Enum.filter(trucks, fn truck ->
      truck.food_items
      |> String.downcase()
      |> String.contains?(items)
    end)
  end

  @spec random(list(Truck.t())) :: list(Truck.t)
  def random([%Truck{} | _tail] = trucks) do
    trucks
    |> Enum.take_random(1)
  end
end
