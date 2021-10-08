defmodule Memorex.Counter do
  @moduledoc """
  """

  def new do
    %{count: 0}
  end

  def add(%{count: count}, increment) do
    %{count: count + increment}
  end

  def as_string(%{count: count}) do
    "the result is #{count}"
  end
end
