defmodule ProtocolMacro do
  alias ProtocolExample.Emoji, as: E

  defmacro eimpl(type) do
    quote do
      defimpl E, for: unquote(type) do
        def mood(value) do
          if value <= 0 do
            IO.puts "😱"
          else
            IO.puts "😀"
          end
        end
      end
    end    
  end

end