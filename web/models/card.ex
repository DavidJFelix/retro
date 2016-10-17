defmodule Retro.Card do
  use Retro.Web, :model

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @derive {Poison.Encoder, only: [:id, :title]}
  schema "cards" do
    field :title, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
