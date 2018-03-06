defmodule StructExample do

  defmodule Simple do
    defstruct [:name, :when]
  end

  defmodule DefaultValues do
    defstruct name: "parllel", when: 2018  
  end
  
end