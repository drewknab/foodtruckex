defmodule FoodtruckWeb.TruckController do
  use FoodtruckWeb, :controller

  alias Foodtruck.Boundary.TruckStore
  alias Foodtruck.Core.TruckRequests

  def random(conn, %{"food" => foods} = _params) when is_binary(foods) do
    filter = String.split(foods, ",")

    random_truck =
      TruckStore.list()
      |> TruckRequests.by_food(filter)
      |> TruckRequests.random()
      |> Enum.map(fn truck -> Map.from_struct(truck) end)
  
    conn
    |> put_status(200)
    |> json(random_truck)
  end

  def random(conn,  _params) do
    random_truck =
      TruckStore.list()
      |> TruckRequests.random()
      |> Enum.map(fn truck -> Map.from_struct(truck) end)

    conn
    |> put_status(200)
    |> json(random_truck)
  end
end
