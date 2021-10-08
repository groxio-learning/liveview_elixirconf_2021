defmodule Memorex.Eraser do
  defstruct ~w[plan phrase]a

  def new(phrase, cycles \\ 3) when is_binary(phrase) do
    string_length = String.length(phrase)

    chunk_size = ceil(string_length / cycles)

    plan =
      0..(string_length - 1)
      |> Enum.shuffle()
      |> Enum.chunk_every(chunk_size)

    %__MODULE__{plan: plan, phrase: String.graphemes(phrase)}
  end

  def erase(%{plan: [current_plan | plan], phrase: phrase}) do
    phrase =
      Enum.reduce(current_plan, phrase, fn index, phrase ->
        char = Enum.at(phrase, index)

        replace_char =
          if String.match?(char, ~r/\w/i) do
            "_"
          else
            char
          end

        List.replace_at(phrase, index, replace_char)
      end)

    %__MODULE__{plan: plan, phrase: phrase}
  end

  def erase(eraser), do: eraser

  def as_string(%{phrase: phrase}) do
    Enum.join(phrase)
  end
end
