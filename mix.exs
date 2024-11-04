defmodule IncompleteBehaviour.MixProject do
  use Mix.Project

  @version "1.0.0"
  @url "https://github.com/coingaming/incomplete_behaviour"

  def project do
    [
      app: :incomplete_behaviour,
      version: @version,
      elixir: "~> 1.14",
      description: "Implement behaviours... partially",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: [:docs]}
    ]
  end

  defp docs do
    [
      main: "IncompleteBehaviour",
      source_ref: "v#{@version}",
      source_url: @url
    ]
  end

  defp package do
    %{
      licenses: ["Apache-2.0"],
      maintainers: ["v0idpwn"],
      links: %{"GitHub" => @url}
    }
  end
end
