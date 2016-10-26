defmodule Retro.CardControllerTest do
  use Retro.ConnCase, async: true

  alias Retro.Card

  ### Test fixtures
  @card1 %{
    title: "Test Card 1"
  }
  @card2 %{
    title: "Test Card 2"
  }


  ### Index controller tests
  describe "index/2" do
    test "returns an array of cards when there are 2+ cards", %{conn: conn} do
      cards = [Card.changeset(%Card{}, @card1), Card.changeset(%Card{}, @card2)]

      # We need the id which was autogenerated, so we'll capture it on insert.
      # Repo.insert returns objects with metadata and atoms for keys.
      # We need no metadata and strings for keys, so we map our conversion
      # to get our expected Map
      expected = cards
                 |> Enum.map(&Repo.insert!(&1))
                 |> Enum.map(&stringify_keys/1)

      response = conn
                 |> get(card_path(conn, :index))
                 |> json_response(200)

      assert response == expected
    end

    test "returns an array with 1 card when there is 1 card", %{conn: conn} do
      card = Card.changeset(%Card{}, @card1)

      # We need the id which was autogenerated, so we'll capture it on insert.
      # Repo.insert returns objects with metadata and atoms for keys.
      # We need no metadata and strings for keys, so we map our conversion
      # to get our expected Map
      expected = card
                 |> Repo.insert!
                 |> stringify_keys

      response = conn
                 |> get(card_path(conn, :index))
                 |> json_response(200)

      assert response == [expected]
    end

    test "returns an empty array when there are no cards", %{conn: conn} do
      expected = []
      response = conn
                 |> get(card_path(conn, :index))
                 |> json_response(200)

      assert response == expected
    end
  end


  ### Show controller tests
  describe "show/2" do
    test "returns a card when it exists", %{conn: conn} do
      expected = %Card{}
                 |> Map.merge(@card1)
                 |> Repo.insert!
                 |> stringify_keys

      response = conn
                 |> get(card_path(conn, :show, expected["id"]))
                 |> json_response(200)

      assert response == expected
    end

    test "returns a server message with 404 error when a card does not exist", %{conn: conn} do
      expected = %{"code" => 404, "description" => "Card not found.", "fields" => ["id"]}

      response = conn
                 |> get(card_path(conn, :show, Ecto.UUID.generate()))
                 |> json_response(404)

      assert response == expected
    end

    test "returns a server message with 400 error when a non-uuid id is provided", %{conn: conn} do
      expected = %{"code" => 400, "description" => "Invalid request.", "fields" => ["id"]}

      response = conn
                 |> get(card_path(conn, :show, "Fake ID"))
                 |> json_response(400)

      assert response == expected
    end
  end


  ### Create controller tests
  describe "create/2" do
    test "returns the card with id when card is valid", %{conn: conn} do
      response = conn
                 |> post(card_path(conn, :create), @card1)
                 |> json_response(201)
      expected = Card
                 |> Repo.get_by!(@card1)
                 |> stringify_keys

      assert response == expected
    end

    test "returns location header when card is valid", %{conn: conn} do
      response = conn
                 |> post(card_path(conn, :create), @card1)
                 |> get_resp_header("location")

      # Response header is a key: array(values) mapping
      expected = [card_path(conn, :show, Repo.get_by!(Card, @card1).id)]

      assert response == expected
    end

    test "returns a server message with 422 error when card is invalid", %{conn: conn} do
      expected = %{"code" => 422, "description" => "JSON but unprocessable.", "fields" => %{"title" => ["can't be blank"]}}

      # Post an empty map
      response = conn
                 |> post(card_path(conn, :create), %{})
                 |> json_response(422)

      assert response == expected
    end

    test "does not return a location header when card is invalid", %{conn: conn} do
      # Post an empty map
      response = conn
                 |> post(card_path(conn, :create), %{})
                 |> get_resp_header("location")

      # Response header is a key: array(values) mapping
      expected = []

      assert response == expected
    end
  end


  ### Update controller tests
  describe "update/2" do
    test "returns updated card when valid complete card is provided", %{conn: conn} do
      expected = %Card{}
                 |> Map.merge(@card1)
                 |> Repo.insert!
                 |> stringify_keys
                 |> Map.merge(%{"title" => "Test Card 2"})

      response = conn
                 |> put(card_path(conn, :update, expected["id"]), expected)
                 |> json_response(200)

      assert response == expected
    end

    test "returns updated card when valid partial card is provided", %{conn: conn} do
      expected = %Card{}
                 |> Map.merge(@card1)
                 |> Repo.insert!
                 |> stringify_keys
                 |> Map.merge(%{"title" => "Test Card 2"})

      patched = expected |> Map.take(["title"])

      response = conn
                 |> patch(card_path(conn, :update, expected["id"]), patched)
                 |> json_response(200)

      assert response == expected
    end

    test "returns a server message with 422 when invalid card is provided", %{conn: conn} do
      updated = %Card{}
                |> Map.merge(@card1)
                |> Repo.insert!
                |> stringify_keys
                |> Map.merge(%{"title" => 1})

      expected = %{"code" => 422, "description" => "JSON but unprocessable.", "fields" => %{"title" => ["is invalid"]}}

      response = conn
                 |> put(card_path(conn, :update, updated["id"]), updated)
                 |> json_response(422)

      assert response == expected
    end

    test "returns server message with 404 when card is not found", %{conn: conn} do
      expected = %{"code" => 404, "description" => "Card not found.", "fields" => ["id"]}
      response = conn
                 |> put(card_path(conn, :update, Ecto.UUID.generate()), @card1)
                 |> json_response(404)

      assert response == expected
    end

    test "returns a server message with 400 when a non-uuid id is provided", %{conn: conn} do
      expected = %{"code" => 400, "description" => "Invalid request.", "fields" => ["id"]}
      response = conn
                 |> put(card_path(conn, :update, "Fake ID"), @card1)
                 |> json_response(400)

      assert response == expected
    end
  end


  ### Delete controller tests
  describe "delete/2" do
    test "returns no content when card did exist", %{conn: conn} do
      card = %Card{}
             |> Map.merge(@card1)
             |> Repo.insert!

      expected = ""
      response = conn
                 |> delete(card_path(conn, :delete, card.id))
                 |> response(204)

      assert response == expected
    end

    test "returns a server message with 404 error when card does not exist", %{conn: conn} do
      expected = %{"code" => 404, "description" => "Card not found.", "fields" => ["id"]}

      response = conn
                 |> delete(card_path(conn, :delete, Ecto.UUID.generate()))
                 |> json_response(404)

      assert response == expected
    end

    test "returns a server message with 400 error when a non-uuid id is provided", %{conn: conn} do
      expected = %{"code" => 400, "description" => "Invalid request.", "fields" => ["id"]}
      response = conn
                 |> put(card_path(conn, :delete, "Fake ID"))
                 |> json_response(400)

      assert response == expected
    end
  end
end
