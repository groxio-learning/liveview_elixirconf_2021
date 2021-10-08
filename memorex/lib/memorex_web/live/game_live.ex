defmodule MemorexWeb.GameLive do
  use MemorexWeb, :live_view

  alias Memorex.Eraser

  @impl true
  def mount(%{"slug" => slug} = _params, _session, socket) do
    passage = Memorex.Library.get_passage_by_slug!(slug)
    {:ok, assign(socket, eraser: Eraser.new(passage.phrase, passage.steps))}
  end

  def render(assigns) do
    ~L"""
    <h1><%= Eraser.as_string(@eraser) %></h1>

    <button type="button" phx-click="guess">increment</button>
    """
  end

  def handle_event("guess", _, socket) do
    {:noreply, socket |> make_a_guess()}
  end

  def make_a_guess(socket) do
    eraser = socket.assigns.eraser
    assign(socket, eraser: Eraser.erase(eraser))
  end
end
