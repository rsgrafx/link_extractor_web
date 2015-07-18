defmodule LinkExtractorWeb.MessagesController do
    use LinkExtractorWeb.Web, :controller

    def create(conn, _params) do 
      {:ok, message, conn} = Plug.Conn.read_body(conn)
      LinkExtractor.inject( message )
      conn |> redirect(to: "/")
    end

    def index(conn, _params) do 
      content = LinkExtractor.get_links
      data = Poison.encode!(content)
      text conn, data
    end
end