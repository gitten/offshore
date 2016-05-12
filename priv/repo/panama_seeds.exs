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

alias Offshore.Address
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

Offshore.AddressSeeds.load()


