defmodule MemorexWeb.GameLive do
  use MemorexWeb, :live_view

  alias Memorex.Eraser

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> restart()}
  end

  def render(assigns) do
    ~L"""
    <h1><%= Eraser.as_string(@eraser) %></h1>

    <button type="button" phx-click="erase">erase</button>
    <button type="button" phx-click="restart">restart</button>
    """
  end

  def handle_event("erase", _, socket) do
    {:noreply, socket |> erase()}
  end

  def handle_event("restart", _, socket) do
    {:noreply, socket |> restart()}
  end

  def erase(socket) do
    eraser = socket.assigns.eraser
    assign(socket, eraser: Eraser.erase(eraser))
  end

  def restart(socket) do
    assign(socket, eraser: Eraser.new("Did you try turning it off and on again?"))
  end
end
