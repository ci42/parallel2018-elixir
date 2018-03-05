defmodule Factorial do

  def factorial(n) when n >= 0 do
    factorial(n, 1)
  end

  defp factorial(0, acc), do: acc
  defp factorial(n, acc), do: factorial(n-1, n*acc)

end
