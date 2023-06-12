defmodule Foodtruck.Core.Truck do
  @moduledoc """
  Truck is the primary type within the system.
  """
  defstruct ~w[id name facility_type location address food_items latitude longitude hours]a

  
  @typedoc """
  Defines the important aspects of a truck.
  Paired down from the original dataset to actionable items.
  """
  @type t() :: %__MODULE__{
    id: integer(),
    name: String.t(),
    facility_type: String.t(),
    location: String.t(),
    address: String.t(),
    food_items: String.t(),
    latitude: float(),
    longitude: float(),
    hours: String.t()
  }

  @doc """
  ## Example
      iex> alias Foodtruck.Core.Truck
      iex> with (%Truck{} = response) = Truck.new(id: "1", name: "hello world taco truck"),
      ...>  do: response.name == "hello world taco truck"
      true
  """
  @spec new(Enum.t()) :: t()
  def new(fields) do
    struct!(__MODULE__, fields)
  end
end
