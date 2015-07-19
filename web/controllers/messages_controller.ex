defmodule LinkExtractorWeb.MessagesController do
    use LinkExtractorWeb.Web, :controller

    alias LinkExtractorWeb.Site
    alias LinkExtractor.Link

    def create(conn, _params) do 
      {:ok, message, conn} = Plug.Conn.read_body(conn)
      LinkExtractor.inject( message )
      Site.capture_from_agent
      conn |> redirect(to: "/") # previous logic.
    end

    def index(conn, _params) do 
      content = LinkExtractor.get_links
      data = Poison.encode!(content)
      text conn, data
    end
end