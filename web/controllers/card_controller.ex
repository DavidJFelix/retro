defmodule Retro.CardController do
  use Retro.Web, :controller

  alias Retro.{Card, Endpoint, ErrorView}
  alias Ecto.UUID


  def index(conn, _params) do
    cards = Repo.all(Card)

    conn
    |> render("index.json", cards: cards)
  end


  def show(conn, %{"id" => id}) do
    case UUID.cast(id) do
      {:ok, uuid} ->
        case Repo.get(Card, uuid) do
          nil ->
            conn
            |> put_status(:not_found)
            |> render(ErrorView, "404.json", %{type: "Card"})

          card ->
            render(conn, "show.json", card: card)
        end

      :error ->
        conn
        |> put_status(:bad_request)
        |> render(ErrorView, "400.json", %{description: "Invalid request.", fields: ["id"]})
    end
  end


  def create(conn, card_params) do
    changeset = Card.changeset(%Card{}, card_params)

    case Repo.insert(changeset) do
      {:ok, card} ->
        Endpoint.broadcast("board:lobby", "new_card", card)
        conn
        |> put_status(:created)
        |> put_resp_header("location", card_path(conn, :show, card.id))
        |> render("show.json", card: card)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ErrorView, "422.json", changeset: changeset)
    end
  end


  def update(conn, card_params) do
    case UUID.cast(card_params["id"]) do
      {:ok, uuid} ->
        case Repo.get(Card, uuid) do
          nil ->
            conn
            |> put_status(:not_found)
            |> render(ErrorView, "404.json", type: "Card")

          card ->
            changeset = Card.changeset(card, card_params)
            case Repo.update(changeset) do
              {:ok, new_card} ->
                Endpoint.broadcast("board:lobby", "updated_card", card)
                render(conn, "show.json", card: new_card)

              {:error, changeset} ->
                conn
                |> put_status(:unprocessable_entity)
                |> render(ErrorView, "422.json", changeset: changeset)
            end
        end

      :error ->
        conn
        |> put_status(:bad_request)
        |> render(ErrorView, "400.json", %{description: "Invalid request.", fields: ["id"]})
    end
  end


  def delete(conn, %{"id" => id}) do
    case UUID.cast(id) do
      {:ok, uuid} ->
        case Repo.get(Card, uuid) do
          nil ->
            conn
            |> put_status(:not_found)
            |> render(ErrorView, "404.json", %{type: "Card"})

          card ->
            Repo.delete!(card)
            send_resp(conn, :no_content, "")
        end

      :error ->
        conn
        |> put_status(:bad_request)
        |> render(ErrorView, "400.json", %{description: "Invalid request.", fields: ["id"]})
    end
  end
end
