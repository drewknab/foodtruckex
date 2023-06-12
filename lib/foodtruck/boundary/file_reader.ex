defmodule Foodtruck.Boundary.FileReader do
  @moduledoc """
  Process CSV files at the boundary. Files parsed here are inserted into an Agent in lieu of a database.
  A database for a product of this variety is probably overkill. I used NimbleCSV here because some wheels don't need to be remade. 
  """
  alias Foodtruck.Core.Truck
  alias NimbleCSV.RFC4180, as: CSV

  @doc """
  Uses Application.fetch_env to handle per environment files.
  Makes use of the function explicitly_map_useful_data/1 to cleanly map data into a truck struct.
  """
  @spec parser() :: list(Truck.t())
  def parser do
    file_name()
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&explicitly_map_useful_data/1)
    |> Enum.to_list()
  end

  defp explicitly_map_useful_data([
      id,
      applicant,
      type,
      _cnn,
      location,
      address,
      _blocklot,
      _block,
      _lot,
      _permit,
      _status,
      food_items,
      _x,
      _y,
      latitude,
      longitude,
      _schedule,
      hours,
      _noisend,
      _approved,
      _received,
      _prior_permit,
      _expiration_date,
      _location,
      _fire_prevention_districts,
      _police_districts,
      _supervisor_districts,
      _zip_codes,
      _neighborhoods
    ]) do
    Truck.new(
      id: id,
      name: applicant,
      facility_type: type,
      location: location,
      address: address,
      food_items: food_items,
      latitude: latitude,
      longitude: longitude,
      hours: hours
    ) 
  end

  defp file_name do
    Application.fetch_env!(:foodtruck, :food_trucks_csv_file)
  end
end
