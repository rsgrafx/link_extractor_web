defmodule LinkExtractorWeb.Site do

  use LinkExtractorWeb.Web, :model

  schema "sites" do
    field :title, :string
    field :url, :string
    timestamps
  end

  @required_fields ~w(title url)
  @optional_fields ~w()

  def capture_from_agent do
    Task.async(fn -> 
      :timer.sleep(4000)
      agent_data = Agent.get( :collector, &List.first(&1) )
      resp = LinkExtractorWeb.Repo.insert!( %LinkExtractorWeb.Site{ title: agent_data.title, url: agent_data.url } )
    end)
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
