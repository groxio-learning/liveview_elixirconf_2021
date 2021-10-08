defmodule Memorex.Counter do
  @moduledoc """
  """

  def new(max) do
    %{count: 0, max: max}
  end

  def increment(%{count: max, max: max}) do
    new(max)
  end

  def increment(%{count: count}) do
    %{count: count + 1}
  end

  def as_string(%{count: count}) do
    "the result is #{count}"
  end
end
