# Script for populating the database. You can run it as:
#
#     mix run priv/repo/panama_seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Offshore.Repo.insert!(%Offshore.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
# Modified version of:
#
#     https://github.com/wsmoak/minty/blob/master/priv/repo/seeds.exs
#
# Expects CSV files in priva/repo/data

alias Offshore.Address
alias Offshore.Edge
alias Offshore.Entity
alias Offshore.Intermediary
alias Offshore.Officer
alias Offshore.Repo

defmodule Offshore.SeedLoader do

  defmacro def_fix_string_fields(string_fields) do
    quote do
      
      def fix_string_field(key, map) when key in unquote(string_fields) do
        v = Map.fetch!(map, key)
        case v do
          "" ->
            Map.update!(map, key, fn _ -> nil end)
          s when is_bitstring(s) ->
            Map.update!(map, key, &String.slice(&1, 0..254))
        end
      end

      def fix_string_field(_key, map), do: map

      # Guards against blank strings and strings that are too long.
      def fix_string_fields(map) do
        keys = Map.keys(map)
        Enum.reduce(keys, map, &fix_string_field(&1, &2))
      end

    end
  end

  defmacro def_fix_date_fields(date_fields) do
    quote do

      def fix_date_field(key, map) when key in unquote(date_fields) do
        v = Map.fetch!(map, key)
        case v do
          "" ->
            Map.update!(map, key, fn _ -> nil end)
          <<d1,d0,"-",m2,m1,m0,"-",y3,y2,y1,y0>> ->
            month = to_string([m2])<>String.downcase(<<m1,m0>>)
            date_str = <<d1,d0,"-">> <>month<> <<"-",y3,y2,y1,y0>>
            {:ok, datetime} = Timex.parse(date_str, "%d-%b-%Y", :strftime)
            {:ok, ecto_date_string} = Timex.format(datetime, "%F", :strftime)
            Map.update!(map, key, fn _ -> ecto_date_string end)
        end
      end

      def fix_date_field(_key, map), do: map

      def fix_date_fields(map) do
        keys = Map.keys(map)
        Enum.reduce(keys, map, &fix_date_field(&1, &2))
      end
    end
  end
        
  def load(path, headers, store_fn) do
    File.stream!(path)
    |> Stream.drop(1)
    |> CSV.decode(headers: headers)
    |> Enum.each(store_fn)
  end
end

defmodule Offshore.AddressSeeds do
  require Offshore.SeedLoader
  alias Offshore.SeedLoader
  
  @string_fields [:address, :countries, :country_codes, :icij_id]
  @headers [:address, :icij_id, :valid_until, :country_codes, :countries, :node_id, :sourceID]
  
  SeedLoader.def_fix_string_fields(@string_fields)
  
  def store_it(row) do
    # IO.inspect row
    row = fix_string_fields(row)
    changeset = Address.changeset(%Address{}, row)
    Repo.insert!(changeset)
  end
  
  def load(path \\ "priv/repo/data/Addresses.csv") do
    SeedLoader.load(path, @headers, &store_it/1)
  end
end

defmodule Offshore.IntermediarySeeds do
  require Offshore.SeedLoader
  alias Offshore.SeedLoader

  @string_fields [:name, :internal_id, :address, :valid_until, :country_codes, :countries, :status, :sourceID]
  @headers [:name, :internal_id, :address, :valid_until, :country_codes, :countries, :status, :node_id, :sourceID]
  
  SeedLoader.def_fix_string_fields(@string_fields)
  
  def store_it(row) do
    # IO.inspect row
    row = fix_string_fields(row)
    changeset = Intermediary.changeset(%Intermediary{}, row)
    Repo.insert!(changeset)
  end
  
  def load(path \\ "priv/repo/data/Intermediaries.csv") do
    SeedLoader.load(path, @headers, &store_it/1)
  end
end

defmodule Offshore.OfficerSeeds do
  require Offshore.SeedLoader
  alias Offshore.SeedLoader

  @string_fields [:name, :icij_id, :valid_until, :country_codes, :countries, :source_id]
  @headers [:name, :icij_id, :valid_until, :country_codes, :countries, :node_id, :sourceID]
  
  SeedLoader.def_fix_string_fields(@string_fields)
  
  def store_it(row) do
    # IO.inspect row
    row = fix_string_fields(row)
    changeset = Officer.changeset(%Officer{}, row)
    Repo.insert!(changeset)
  end
  
  def load(path \\ "priv/repo/data/Officers.csv") do
    SeedLoader.load(path, @headers, &store_it/1)
  end
end

defmodule Offshore.EntitySeeds do
  require Offshore.SeedLoader
  alias Offshore.SeedLoader

  @string_fields [:name, :original_name, :former_name, :jurisdiction, :jurisdiction_description, :company_type, :address, :internal_id, :status, :service_provider, :ibcRUC, :country_codes, :countries, :note, :valid_until, :sourceID]
  @date_fields [:incorporation_date, :inactivation_date, :struck_off_date, :dorm_date]
  @headers [:name, :original_name, :former_name, :jurisdiction, :jurisdiction_description, :company_type, :address, :internal_id, :incorporation_date, :inactivation_date, :struck_off_date, :dorm_date, :status, :service_provider, :ibcRUC, :country_codes, :countries, :note, :valid_until, :node_id, :sourceID]
  
  SeedLoader.def_fix_string_fields(@string_fields)
  SeedLoader.def_fix_date_fields(@date_fields)
  
  def store_it(row) do
    row = row
    |> fix_string_fields()
    |> fix_date_fields()
    changeset = Entity.changeset(%Entity{}, row)
    Repo.insert!(changeset)
  end
  
  def load(path \\ "priv/repo/data/Entities.csv") do
    SeedLoader.load(path, @headers, &store_it/1)
  end
end

defmodule Offshore.EdgeSeeds do
  require Offshore.SeedLoader
  alias Offshore.SeedLoader

  @string_fields [:rel_type]
  @headers [:node_1, :rel_type, :node_2]
  
  SeedLoader.def_fix_string_fields(@string_fields)
  
  def store_it(row) do
    row = fix_string_fields(row)
    changeset = Edge.changeset(%Edge{}, row)
    Repo.insert!(changeset)
  end
  
  def load(path \\ "priv/repo/data/all_edges.csv") do
    SeedLoader.load(path, @headers, &store_it/1)
  end
end

Offshore.AddressSeeds.load()
Offshore.IntermediarySeeds.load()
Offshore.OfficerSeeds.load()
Offshore.EntitySeeds.load()
Offshore.EdgeSeeds.load()
