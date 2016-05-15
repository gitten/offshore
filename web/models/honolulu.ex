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
