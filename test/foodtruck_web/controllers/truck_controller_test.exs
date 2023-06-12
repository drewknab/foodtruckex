defmodule FoodtruckWeb.TruckControllerTest do
  use FoodtruckWeb.ConnCase

  alias Foodtruck.Boundary.TruckStore
  alias Foodtruck.Core.TruckRequests

  test "GET /truck/random", %{conn: conn} do
    response =
      conn
      |> get(~p"/truck/random")
      |> json_response(200)

    trucks =
      TruckStore.list()

    assert eventually_match(trucks, response)
  end

  defp eventually_match(trucks, response) do
    Stream.repeatedly(fn ->
      TruckRequests.random(trucks)
      |> Enum.map(fn truck -> Map.from_struct(truck) end)
    end)
    |> Enum.find(fn truck -> 
      Enum.at(truck, 0).id == Enum.at(response, 0)["id"] 
    end)
  end
end
