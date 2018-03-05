defmodule MacroExample do

  defmacro ifnot(expr, body) do
    quote do
      if(!unquote(expr), unquote(body))
    end 
  end

  def useMacro do
    ifnot(false) do
      IO.puts "Just used the ifnot macro"
    end
  end

end