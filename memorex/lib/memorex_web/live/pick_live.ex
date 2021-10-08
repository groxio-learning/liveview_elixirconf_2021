defmodule MemorexWeb.PickLive do
  use MemorexWeb, :live_view

  alias Memorex.Counter

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, counter: Counter.new())}
  end

  def render(assigns) do
    ~L"""
    <h1><%= Counter.as_string(@counter) %></h1>

    <button type="button" phx-click="increment">increment</button>
    """
  end

  def handle_event("increment", _, socket) do
    {:noreply, socket |> increment()}
  end

  def increment(socket) do
    counter = socket.assigns.counter
    assign(socket, counter: Counter.add(counter, 1))
  end
end
