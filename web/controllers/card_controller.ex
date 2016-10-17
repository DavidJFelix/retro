defmodule Retro.CardController do
  use Retro.Web, :controller

  alias Retro.Card
  alias Ecto.UUID

  def index(conn, _params) do
    # TODO 1: implement the index controller
    # HINT: Repo.all(Model) will query the repo and return a collection of all Models
    # HINT: render(conn, View, "documemnt.ext", params: params) will render a view
    conn
  end


  def show(conn, %{"id" => id}) do
    # TODO 2: implement the show controller
    # HINT: Repo.get(Model, id) can be used to get a model by id
    # HINT: Repo.get(Model, id) returns a Model or nil
    # HINT: UUID.cast("str") will ensure a string is a uuid and returns
    # {:ok, uuid} or :error
    conn
    |> put_status(:not_found)
    |> render(Retro.ErrorView, "404.json", %{type: "Card"})
  end


  def create(conn, card_params) do
    # TODO 3: implement the create controller
    # HINT: Repo.insert(Changeset) will create a db resource
    # HINT: Repo.insert only inserts valid changesets, returning {:ok, Model} or {:error, Changeset}
    # HINT: put_resp_header(conn, "location", url) is how you set a location header
    # HINT: card_path can be used to get the URL
    # HINT: an HTTP 422 is an "unprocessable_entity" error
    conn
  end


  def update(conn, card_params) do
    # TODO 4: implement the update controller
    # HINT: pretty much just combine show and create
    # HINT: Repo.update works a lot like Repo.insert
    # HINT: changeset takes the Model as the first argument. Repo.get gives a model.
    # HINT: in order to pass the 404 test, we cannot Upsert, we must get then update
  end


  def delete(conn, %{"id" => id}) do
    # TODO 5: implement the delete controller
    # HINT: like update, if we want to pass the 404 test we cannot blindly delete, we must get first
    # HINT: Repo.delete(Model). You know what to do.
  end
end
