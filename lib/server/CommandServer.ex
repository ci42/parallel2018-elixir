defmodule CommandServer do
  import Factorial

  def start do
    spawn fn -> loop() end
  end

  defp loop(state \\ %{}) do
    receive do
      {reply_to, :fac, n} when is_pid(reply_to) and is_integer(n) and n > 0 -> 
        state = case Map.get(state, n) do
          :nil ->
            IO.puts "Computing factorial for #{n}"
            Map.put(state, n, factorial(n))
          _ ->
            IO.puts "Factorial for #{n} already computed"
            state
        end
        send reply_to, state[n]
        loop(state)
      :stop ->
        IO.puts "Received stop message, shutting down"
        exit(:normal)
      _ ->
        IO.puts "Ignoring unknown message"
        loop(state)
    after
      360000 -> 
        IO.puts "Shutting down after 5 minutes of inactivity"
        exit(:normal)
    end
  end

end
