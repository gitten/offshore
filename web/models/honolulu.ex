defmodule Offshore.Honolulu do
  alias Offshore.Repo
  alias Offshore.Address
  alias Offshore.Edge
  alias Offshore.Entity
  alias Offshore.Intermediary
  alias Offshore.Officer
  import Ecto.Query, only: [from: 2]

  def addresses() do
    Repo.all from a in Address,
      where: ilike(a.address, ^"%honolulu%")
  end

  def node_from(node_id) do
    (Repo.all from o in Officer,
      where: o.node_id == ^node_id)
    ++ (Repo.all from e in Entity,
      where: e.node_id == ^node_id)
    ++ (Repo.all from i in Intermediary,
      where: i.node_id == ^node_id)
  end
  
  def connect_edge_from(node_id, %Edge{node_1: nid1, node_2: nid2})
  when node_id == nid1 do
    node_from(nid2)
  end
  def connect_edge_from(node_id, %Edge{node_1: nid1, node_2: nid2})
  when node_id == nid2 do
    node_from(nid1)
  end
  def connect_edge_from(_node_id, _edge), do: []

  # %Offshore.Officer{__meta__: #Ecto.Schema.Metadata<:loaded>,
  # countries: "United States", country_codes: "USA", icij_id: nil, id: 14171,
  # inserted_at: #Ecto.DateTime<2016-05-15 04:57:50>, name: "Joseph Y. Sotomura",
  # node_id: 82342, sourceID: "Offshore Leaks",
  # updated_at: #Ecto.DateTime<2016-05-15 04:57:50>,
  # valid_until: "The Offshore Leaks data is current through 2010"}

  # %Offshore.Intermediary{__meta__: #Ecto.Schema.Metadata<:loaded>, address: nil,
  #  countries: "United States", country_codes: "USA", id: 26755,
  #  inserted_at: #Ecto.DateTime<2016-05-15 04:55:56>, internal_id: nil,
  #  name: "Grant Koichi Kidani", node_id: 291339, sourceID: "Offshore Leaks",
  #  status: nil, updated_at: #Ecto.DateTime<2016-05-15 04:55:56>,
  #  valid_until: "The Offshore Leaks data is current through 2010"}

  # %Offshore.Entity{__meta__: #Ecto.Schema.Metadata<:loaded>,
  #  address: "3rd Floor, BCI Building P.O. Box 208 Avarua, Rarotonga COOK ISLANDS;300 Kidani Law Center 233 Merchant Street Honolulu, HI 96813-2995 HAWAII",
  #  company_type: "Cook Islands Asset Protection Trust - 3520A",
  #  countries: "United States;Cook Islands", country_codes: "USA;COK",
  #  dorm_date: nil, former_name: nil, ibcRUC: "5281/2005", id: 34760,
  #  inactivation_date: nil, incorporation_date: #Ecto.Date<2005-07-05>,
  #  inserted_at: #Ecto.DateTime<2016-05-15 06:24:09>, internal_id: nil,
  #  jurisdiction: "COOK", jurisdiction_description: "Cook Islands",
  #  name: "Laksmi Trust", node_id: 172633, note: nil, original_name: nil,
  #  service_provider: "Portcullis Trustnet", sourceID: "Offshore Leaks", ...}
  
  # %Offshore.Address{__meta__: #Ecto.Schema.Metadata<:loaded>,
  # address: "MARIA MOKOLOMBAN 357 OPIHIKAO PL HONOLULU HI 96825, USA",
  # countries: "United States", country_codes: "USA",
  # icij_id: "C9FC28123A52ED8A0D78CE56F8BF0638", id: 408576,
  # inserted_at: #Ecto.DateTime<2016-05-12 09:43:00>, node_id: 14049566,
  # sourceID: "Panama Papers", updated_at: #Ecto.DateTime<2016-05-12 09:43:00>,
  # valid_until: "The Panama Papers  data is current through 2015"}
  def combine(%Entity{name: name, original_name: original_name, former_name: former_name, company_type: company_type, address: entity_address, node_id: node_id},
        %Address{address: address}) do
    %{address: address,
      type: "officer",
      name: name,
      original_name: original_name,
      former_name: former_name,
      company_type: company_type,
      entity_address: entity_address,
      url: "https://offshoreleaks.icij.org/nodes/#{node_id}"
    }
  end
  def combine(%Officer{name: name, node_id: node_id},
        %Address{address: address}) do
    %{address: address,
      type: "officer",
      name: name,
      url: "https://offshoreleaks.icij.org/nodes/#{node_id}"
    }
  end
  def combine(%Intermediary{name: name, node_id: node_id},
        %Address{address: address}) do
    %{address: address,
      type: "intermediary",
      name: name,
      url: "https://offshoreleaks.icij.org/nodes/#{node_id}"
    }
  end
  
  def edges_from(%Address{node_id: node_id}=address) do
    edges = Repo.all from e in Edge,
      where: e.node_1 == ^node_id or e.node_2 == ^node_id

    Enum.flat_map(edges, &connect_edge_from(node_id, &1))
    |> Enum.map(&combine(&1, address))

  end
 
  def nodes() do
    addresses
    |> Enum.flat_map(&edges_from/1)
  end
  
end
