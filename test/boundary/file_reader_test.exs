defmodule Foodtruck.Boundary.FileReaderTest do
  use ExUnit.Case

  alias Foodtruck.Boundary.FileReader
  alias Foodtruck.Core.Truck

  test "file parsed into list of trucks" do
    trucks = FileReader.parser()

    assert is_list(trucks)
    assert length(trucks) == 14
  end

  test "list item is a truck" do
    [head | _tail] = FileReader.parser()

    assert match?(%Truck{}, head)
  end
end
