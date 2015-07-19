defmodule LinkExtractorWebTest do
  use ExUnit.Case, async: false
  use Plug.Test

  alias LinkExtractor.Link

  # User sends an email 
  @messages """
  Orion, This is a message that came it.. today. LOL check this out http://www.orionengleton.com Its your new website.
  """
  @expected_link %Link{url: "http://www.orionengleton.com", title: "Learning to Dream in Color and Code. | Orion Engleton - Web Developer specializing in Ruby, AngularJS and" }

  test "When parsing the email body we expect to store url" do
    response = conn(:post, "/messages", @messages) |> send_request
    assert response.status == 302
    :timer.sleep(2000)
    assert length( LinkExtractor.get_links ) > 0
  end

  test "get the results back" do
    conn(:post, "/messages", @messages) |> send_request
    response = conn(:get, "/messages") |> send_request
    :timer.sleep(2000) #Needed * if your making post calls that call out to an api.
    assert response.status == 200
    assert length( LinkExtractor.get_links ) > 0
  end

  def post path, body do 
    HTTPoison.request(:post, "http://localhost:4001#{path}",
                      %{"data" => body, "format" => "json"},
                      [{"Accept", "application/json"}])
  end

  def get path do 
    HTTPoison.get "http://localhost:4001#{path}"
  end

  defp send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> LinkExtractorWeb.Endpoint.call([])
  end

end
