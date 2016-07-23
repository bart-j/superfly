defmodule FlightController do
  use Application
  alias Nerves.Networking
  alias Nerves.InterimWiFi

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    unless :os.type == {:unix, :darwin} do     # don't start networking unless we're on nerves
      Nerves.InterimWiFi.setup "wlan0", ssid: "A&B", key_mgmt: :"WPA-PSK", psk:   "<mypassword>"
      {:ok, _} = Networking.setup :eth0
    end

    # Define workers and child supervisors to be supervised
    children = [
      # worker(FlightController.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FlightController.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
