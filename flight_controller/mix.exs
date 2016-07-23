defmodule FlightController.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :flight_controller,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.1.4"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {FlightController, []},
     applications: [:logger, :nerves_networking, :nerves_network_interface, :nerves_firmware_http, :nerves_interim_wifi]]
  end

  def deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_network_interface, "~> 0.3.2"},
     {:nerves_networking, github: "nerves-project/nerves_networking"},
     {:nerves_interim_wifi, "~> 0.0.2"},
     {:nerves_firmware_http, github: "nerves-project/nerves_firmware_http"}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
