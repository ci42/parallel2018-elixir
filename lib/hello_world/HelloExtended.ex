defmodule HelloExtended do
  alias Elixir.IO, as: Fmt

  @doc """
  yeah - docstrings with support for doctest

    ## How to use it

      iex> HelloExtended.greet "parallel 2018"
      "Nice to meet you parallel 2018"
      nil

      iex> HelloExtended.greet "Christoph"
      "Welcome Back"
      nil
      
  """
  # def greet(name) when is_list(name) or is_binary(name) or is_atom(name) do
  #   private_greet "Have we met yet, #{name}?"
  # end
  
  def greet(supplier) when is_function(supplier) do
    private_greet("Hello #{supplier.()}")
  end

  def greet("Christoph") do
    private_greet "Welcome back"
  end

  def greet(name) when is_binary(name) do
    private_greet "Nice to meet you, #{name}"
  end

  def greet(name) when is_list(name) do
    private_greet "You are so slow, #{name}"
  end

  def greet(name) do
    raise "You shall not pass, #{name}"
  end
 
  @spec greet(binary() | list()) :: nil
  defp private_greet(msg) do
    Fmt.puts msg
    nil
  end

end