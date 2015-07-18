defmodule LinkExtractorWebTest do
  use ExUnit.Case

  alias LinkExtractor.Link

  # User sends an email 
  @message """
  Orion, This is a message that came it.. today. LOL check this out http://www.orionengleton.com Its your new website.
  """

  @expected_link %Link{url: "http://www.orionengleton.com", title: "Learning to Dream in Color and Code. | Orion Engleton - Web Developer specializing in Ruby, AngularJS and" }

  test "When parsing the email body we expect to store url" do
    post "/messages", @messages


    LinkExtractor.inject(@message)
    :timer.sleep(4000)
    assert LinkExtractor.get_links == [ @expected_link ]

  end

  def post path, body do 
    HTTPoison.post "http://localhost:4001#{path}", body
  end
end
