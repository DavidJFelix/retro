defmodule Retro.CardControllerTest do
  use Retro.ConnCase, async: true

  alias Retro.Card

  ### Test fixtures
  @card1 %Card{
    title: "Test Card 1"
  }
  @card2 %Card{
    title: "Test Card 2"
  }


  # TODO 1: Uncomment example tests, pass them then write the todo tests
  ### Index controller tests
  describe "index/2" do
    test "Returns an array of cards when there are 2+ cards", %{conn: conn} do
      # cards = [ Card.changeset(%Card{}, @card1),
      #           Card.changeset(%Card{}, @card2)]
      #
      # Enum.each(cards, &Repo.insert!(&1))
      #
      # response = conn
      # |> get(user_path(conn, :index))
      # |> json_response(200)
      #
      # expected = [
      #   %{},
      #   %{}
      # ]
    end

    test "Returns an array with 1 card when there is 1 card" do
      # TODO
    end

    test "Returns an empty array when there are no cards" do
      # TODO
    end

    test "Returns 200 HTTP status code" do
      # conn = get conn, card_path(conn, :index)
      # assert
    end
  end


  # TODO 2: Write todo tests, pass them then uncomment example test and pass it
  ### Show controller tests
  describe "show/2" do
    test "Returns a card when it exists" do
      # TODO
    end

    test "Returns 200 HTTP status code when card exists" do
    end

    test "Returns a server message with 404 error when a card does not exist" do
    end

    test "Returns 404 HTTP status when a card does not exist" do
    end

    test "Returns a server message with 400 error when a non-uuid id is provided" do
    end

    test "Returns a 400 HTTP status when a non-uuid id is provided" do
    end
  end


  # TODO 3:
  ### Create controller tests
  describe "create/2" do
    test "create should return the card with id when card is valid" do
    end

    test "create should return a 201 HTTP status when card is valid" do
    end

    test "create should set location header when card is valid" do
    end

    test "create should return a server message with 422 error when card is invalid" do
    end

    test "create should return a 422 HTTP status when a card is invalid" do
    end

    test "create should not set a location header when card is invalid" do
    end
  end


  # TODO 4:
  ### Update controller tests
  describe "update/2" do
    test "update should return updated card when valid complete card is provided" do
    end

    test "update should return updated card when valid partial card is provided" do
    end

    test "update should return 200 HTTP status code when valid complete card is provided" do
    end

    test "update should return 200 HTTP status code when valid partial card is provided" do
    end

    test "update should return a server message with 422 when invalid card is provided" do
    end

    test "update should return 422 HTTP status code when invalid card is provided" do
    end

    test "update should return server message with 404 when card is not found" do
    end

    test "update should return 404 HTTP status code when card is not found" do
    end

    test "update should return a server message with 400 when a non-uuid id is provided" do
    end

    test "update should return 400 HTTP status code when a non-uuid id is provided" do
    end
  end


  # TODO 5:
  ### Delete controller tests
  describe "delete/2" do
    test "delete should return no content when card did exist" do
    end

    test "delete should return 204 HTTP status code when card did exist" do
    end

    test "delete should return a server message with 404 error when card does not exist" do
    end

    test "delete should return 404 HTTP status code when card does not exist" do
    end

    test "delete should return a server message with 400 error when a non-uuid id is provided" do
    end

    test "delete should return 400 HTTP status code when a non-uuid id is provided" do
    end
  end
end
