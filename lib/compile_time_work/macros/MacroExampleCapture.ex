defmodule MacroExampleCapture do

  defmacro ifnot(body) do
    quote do
      a = var!(a)
      if(!a, unquote(body))
    end 
  end

  def useMacro do
    a = false
    ifnot do
      IO.puts "Just used the ifnot macro"
    end
  end

end