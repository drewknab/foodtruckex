defmodule Foodtruck.Boundary.TruckStoreTest do
  use ExUnit.Case

  alias Foodtruck.Boundary.TruckStore
  alias Foodtruck.Core.Truck

  test "file parsed into list of trucks" do
    trucks = TruckStore.list()

    assert is_list(trucks)
    assert length(trucks) == 14
  end

  test "list item is a truck" do
    [head | _tail] = TruckStore.list()

    assert match?(%Truck{}, head)
  end
end
