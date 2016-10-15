defmodule Retro.CardControllerTest do
  use Retro.ConnCase

  alias Retro.Card


  # TODO 1: Uncomment example tests, pass them then write the todo tests
  ### Index controller tests
  test "index should return an array of cards when there are 2+ cards" do
  end

  test "index should return an array with 1 card when there is 1 card" do
    # TODO
  end

  test "index should return an empty array when there are no cards" do
    # TODO
  end


  # TODO 2: Write todo tests, pass them then uncomment example test and pass it
  ### Show controller tests
  test "show should return a card when it exists" do
    # TODO
  end

  test "show should return a server message with 404 error when a card does not exist" do
  end

  test "show should return a 404 HTTP status when a card does not exist" do
  end

  test "show should return a server message with 400 error when a non-uuid id is provided" do
  end

  test "show should return a 400 HTTP status when a non-uuid id is provided" do
  end


  # TODO 3:
  ### Create controller tests
  test "create should return the card with id when card is valid" do
  end

  test "create should return a 201 HTTP status when card is valid" do
  end

  test "create should set location header when card is valid" do
  end

  test "create should return a server message with 422 when card is invalid" do
  end

  test "create should return a 422 HTTP status when a card is invalid" do
  end

  test "create should not set a location header when card is invalid" do
  end


  # TODO 4:
  ### Update controller tests
  test "update should return a " do
  end


  # TODO 5:
  ### Delete controller tests
  test "" do
  end
end
