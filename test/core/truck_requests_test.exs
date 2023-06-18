defmodule Foodtruck.Core.TruckRequestsTest do
  use ExUnit.Case

  alias Foodtruck.Core.TruckRequests
  alias Foodtruck.Boundary.TruckStore

  test "filter food trucks by ceviche and noodle" do
    trucks = 
      TruckStore.list()
      |> TruckRequests.by_food(["ceviche", "noodle"])

    assert is_list(trucks)
    assert length(trucks) == 6
  end

  test "filter food trucks by hamburger and fruit" do
    trucks = 
      TruckStore.list()
      |> TruckRequests.by_food(["hamburger", "fruit"])

    assert is_list(trucks)
    assert length(trucks) == 0
  end

  test "no filter" do
    trucks = 
      TruckStore.list()
      |> TruckRequests.by_food([])

    assert is_list(trucks)
    assert length(trucks) == 14
  end

  test "random food truck" do
    trucks = TruckStore.list()

    random_truck = TruckRequests.random(trucks)

    assert is_list(random_truck)
    assert length(random_truck) == 1
    assert eventually_match(trucks, "1577179")
    assert eventually_match(trucks, "1569152")
  end

  test "filtered random food truck" do
    trucks = 
      TruckStore.list()
      |> TruckRequests.by_food(["noodle"])

    random_truck = TruckRequests.random(trucks)

    assert is_list(random_truck)
    assert length(random_truck) == 1
    assert eventually_match(trucks, "1565593")
    assert eventually_match(trucks, "1565571")
  end

  defp eventually_match(truck, response) do
    Stream.repeatedly(fn -> TruckRequests.random(truck) end)
    |> Enum.find(fn truck -> 
      [truck_head | _] = truck
      truck_head.id == response 
    end)
  end
end
