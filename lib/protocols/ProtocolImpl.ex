# defmodule ProtocolImpl do
#   alias ProtocolExample.Emoji, as: E

#   defimpl E, for: Integer do
#     def mood(value) do
#       if value <= 0 do
#         IO.puts "😱"
#       else
#         IO.puts "😀"
#       end
#     end
#   end

#   defimpl E, for: Float do
#     def mood(value) do
#       if value <= 0 do
#         IO.puts "😱"
#       else
#         IO.puts "😀"
#       end
#     end
#   end

#   defimpl String.Chars, for: PID do
#     def to_string(value) do
#       Kernel.inspect value
#     end
#   end

# end
