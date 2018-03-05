defmodule StateServer do

  def start do
    spawn fn -> loop() end
  end

  defp loop(state \\ :nil) do
    receive do
      {reply_to, :get} when is_pid(reply_to)-> 
        send reply_to, state
        loop(state)
      {:put, value} -> 
          loop(value)
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
