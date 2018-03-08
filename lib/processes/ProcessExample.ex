defmodule ProcessExample do

  def start(max_procs, max_fac) when max_procs > 0 and max_fac > 0 do
    Process.flag(:trap_exit, false)
    start_workers max_procs, max_fac
    receive_results()
  end

  defp receive_results do
    receive do
      {result, pid} -> 
        IO.puts "received result #{result} from #{pid}"
        receive_results()
    after
      5000 -> 
        IO.puts "timeout"
        exit(:normal)
    end
    
  end

  defp start_workers(0, _) do
    :ok
  end

  defp start_workers(n, max_fac) when is_integer(n) and n > 0 do
    spawn(ProcessExample, :worker, [self(), &Factorial.factorial/1, :rand.uniform(max_fac)])
    start_workers(n-1, max_fac)
  end

  defp start_workers(_, _) do
    exit("start_workers requires two positiv integers as arguments")
  end

  def worker(home, func, n) do
    result = func.(n)
    send(home, {result, self()})
  end

end