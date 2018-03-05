defmodule ProtocolExample do
  
  defprotocol Emoji do   
    def mood(value)
  end
  
  defimpl Emoji, for: Atom do
    def mood(value) do
      if value do
        IO.puts "😀"
      else
        IO.puts "😱"
      end
    end
  end

end