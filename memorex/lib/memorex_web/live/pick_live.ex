defmodule MemorexWeb.PickLive do
  use MemorexWeb, :live_view

  alias Memorex.Counter

  @impl true
  def mount(_params, _session, socket) do
    # TODO: pick the current passage based on slug?
    passages = passages()
    counter = Counter.new(length(passages) - 1)

    socket =
      socket
      |> assign(counter: counter)
      |> assign(passages: passages)
      |> assign_passage()

    {:ok, socket}
  end

  defp assign_passage(%{assigns: %{counter: counter}} = socket) do
    counter.count |> IO.inspect(label: "count")
    passage = Enum.at(socket.assigns.passages, counter.count)
    assign(socket, :passage, passage)
  end

  def render(assigns) do
    ~L"""
    <h1><%= Counter.as_string(@counter) %></h1>
    <button type="button" phx-click="increment">increment</button>

    <h1>Passages</h1>

    <div><%= live_patch(@passage.phrase, to: "/game/#{@passage.slug}") %></div>
    """
  end

  def handle_event("increment", _, socket) do
    {:noreply, socket |> increment() |> assign_passage()}
  end

  def increment(socket) do
    counter = socket.assigns.counter
    assign(socket, counter: Counter.increment(counter))
  end

  def passages do
    [
      %{slug: "did-you-try", phrase: "Did you try turning it off and on again?", steps: 3},
      %{slug: "nam-neque-justo", phrase: "Nam neque justo, porta vel ligula vel.", steps: 7},
      %{slug: "do-fun-things", phrase: "Do fun things with big, loud worker bees.", steps: 5},
    ]
  end
end
