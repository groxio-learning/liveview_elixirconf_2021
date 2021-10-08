defmodule MemorexWeb.GameLive do
  # @phrases [
  #   "Did you try turning it off and on again?",
  #   "Nam neque justo, porta vel ligula vel.",
  #   "Do fun things with big, loud worker bees.",
  # ]

  use MemorexWeb, :live_view

  alias Memorex.Eraser

  @impl true
  def mount(_params, _session, socket) do
    passages = MemorexWeb.PickLive.passages()

    {:ok, assign(socket, eraser: new_eraser())}
  end

  def render(assigns) do
    ~L"""
    <div style="font-family: monospace;">
      <%= Eraser.as_string(@eraser) %>
    </div>

    <button type="button" phx-click="erase">erase</button>
    <button type="button" phx-click="reset">reset</button>

    <span style="font-family: monospace;">
      steps: <%= length(@eraser.plan) %>
    </span>
    """
  end

  def handle_event("erase", _, socket) do
    {:noreply, socket |> erase()}
  end

  def handle_event("reset", _, socket) do
    {:noreply, assign(socket, eraser: new_eraser())}
  end

  def erase(%{assigns: %{eraser: eraser}} = socket) do
    assign(socket, eraser: Eraser.erase(eraser))
  end

  defp new_eraser, do: Eraser.new(new_phrase(), Enum.random(2..8))

  defp new_phrase, do: Enum.random(@phrases)
end
