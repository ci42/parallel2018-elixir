defmodule ProcessScaling do

  def compute_sequential(max_iter, fac), do: compute_sequential(max_iter, fac, 0)

  def compute_sequential(0, _, acc), do: acc

  def compute_sequential(max_iter, fac, acc) when max_iter > 0 and fac > 0 do
    f = Factorial.factorial fac
    compute_sequential(max_iter-1, fac, acc + f)
  end
  
  def compute_parallel(max_procs, fac) when max_procs > 0 and fac > 0 do
    Process.flag(:trap_exit, true)
    start_workers max_procs, fac
    receive_results(0)
  end

  defp receive_results(acc) do
    receive do
      {result, _pid} -> 
        receive_results(result + acc)
      {:EXIT, _pid, _reason} -> 
        receive_results(acc)
    after
      5000 -> 
        acc
    end
  end

  defp start_workers(0, _) do
    :ok
  end

  defp start_workers(n, fac) when is_integer(n) and n > 0 do
    spawn_link(ProcessExample, :worker, [self(), &Factorial.factorial/1, fac])
    start_workers(n-1, fac)
  end

  defp start_workers(_, _) do
    exit("start_workers requires two positiv integers as arguments")
  end

  def worker(home, func, n) do
    result = func.(n)
    send(home, {result, self()})
  end

end