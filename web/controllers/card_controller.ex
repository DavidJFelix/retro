defmodule Retro.CardController do
  use Retro.Web, :controller

  alias Retro.Card
  alias Ecto.UUID

  def index(conn, _params) do
    # TODO 1: implement the index controller
    # HINT: Repo.all(Model) will query the repo and return a collection of all Models
    # HINT: render(conn, View, "documemnt.ext", params: params) will render a view
  end


  def show(conn, %{"id" => id}) do
    # TODO 2: implement the show controller
    # HINT: Repo.get(Model, id) can be used to get a model by id
    # HINT: Repo.get(Model, id) returns an item or nil
    # HINT: UUID.cast("str") will ensure a string is a uuid and returns
    # {:ok, uuid} or :error
  end


  def create(conn, card_params) do
    # TODO 3: implement the create controller
  end


  def update(conn, card_params) do
  end


  def delete(conn, %{"id" => id}) do
  end
end
