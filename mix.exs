defmodule LinkExtractorWeb.Mixfile do
  use Mix.Project

  def project do
    [app: :link_extractor_web,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {LinkExtractorWeb, []},
     applications: [:link_extractor, :phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :postgrex]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [ {:phoenix, "~> 0.14"},
      {:phoenix_ecto, "~> 0.5"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 1.1"},
      {:phoenix_live_reload, "~> 0.4", only: :dev},
      {:cowboy, "~> 1.0"},
      {:link_extractor, github: "rsgrafx/link_extractor"},
      {:poolboy, "~> 1.4"},
      {:httpoison, "~> 0.7"},
      {:hackney, "~> 1.0"},
      {:cors_plug, "~> 0.1.3"},
   ]
  end
end
