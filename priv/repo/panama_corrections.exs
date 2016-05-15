# Script for correcting the data. You can run it as:
#
#     mix run priv/repo/panama_correctionss.exs
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

alias Offshore.Edge
alias Offshore.Repo
import Ecto.Query, only: [from: 2]

defmodule Offshore.FixEdges do
  def fix() do
    edge = Repo.one from e in Edge,
      where: e.node_2 == 14009136 and
             e.node_1 == 12204314
    Repo.update!(Edge.changeset(edge, %{node_1: 12107921}))

    edge = Repo.one from e in Edge,
      where: e.node_2 == 14009987 and
             e.node_1 == 12203842
    Repo.update!(Edge.changeset(edge, %{node_1: 12108371}))

    edge = Edge.changeset(%Edge{}, %{node_1: 12108372, node_2: 14009987, rel_type: "registered_address"})
    Repo.insert!(edge)

    edge = Repo.one from e in Edge,
      where: e.node_2 == 14012855 and
             e.node_1 == 12209544
    Repo.update!(Edge.changeset(edge, %{node_1: 12113850}))

    edge = Repo.one from e in Edge,
      where: e.node_2 == 14012875 and
             e.node_1 == 12193861
    Repo.update!(Edge.changeset(edge, %{node_1: 12109785}))

    edge = Repo.one from e in Edge,
      where: e.node_2 == 14049566 and
             e.node_1 == 12124219
    Repo.update!(Edge.changeset(edge, %{node_1: 12162730}))
    
    edge = Repo.one from e in Edge,
      where: e.node_2 == 14020546 and
             e.node_1 == 12218292
    Repo.update!(Edge.changeset(edge, %{node_1: 12122231}))
    
    edge = Repo.one from e in Edge,
      where: e.node_2 == 14003930 and
             e.node_1 == 12193464
    Repo.update!(Edge.changeset(edge, %{node_1: 12099823}))
  end
end

Offshore.FixEdges.fix()
