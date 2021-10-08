defmodule Memorex.Eraser do
  def new(phrase, steps) do
    size = String.length(phrase)
    chunk_size = div(size + steps - 1, steps)
    plan = 0..(size - 1) |> Enum.shuffle |> Enum.chunk_every(chunk_size)
    %{plan: plan, phrase: phrase}
  end

  def erase(%{plan: []} = eraser) do
    eraser
  end

  def erase(%{plan: [head_plan | tail_plan], phrase: phrase}) do
    new_phrase = enact_plan_step(head_plan, phrase)

    %{plan: tail_plan, phrase: new_phrase}
  end

  def as_string(%{phrase: phrase}), do: phrase

  defp enact_plan_step(plan_step, phrase) do
    graphemes = String.graphemes(phrase)

    Enum.reduce(plan_step, graphemes, fn (plan_index, acc) ->
      List.replace_at(acc, plan_index, "_")
    end)
    |> Enum.join()
  end
end
