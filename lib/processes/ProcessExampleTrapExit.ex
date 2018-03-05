defmodule ProcessExampleTrapExit do
  import Integer

  def start(max_procs, max_fac) when max_procs > 0 and max_fac > 0 do
    Process.flag(:trap_exit, true)
    start_workers max_procs, max_fac
    receive_results()
  end

  defp receive_results do
    receive do
      {result, pid} -> 
        IO.puts "received result #{result} from #{pid}"
        receive_results()
      {:EXIT, pid, reason} -> 
        IO.puts "received exit signal from process #{pid}, reason: #{reason}"
        receive_results()
    after
      5000 -> 
        IO.puts "timeout"
        Process.flag(:trap_exit, false)
        exit(:normal)
    end
  end

  defp start_workers(0, _) do
    :ok
  end

  defp start_workers(n, max_fac) when is_integer(n) and n > 0 and is_even(n) do
    spawn_link(ProcessExample, :worker, [self(), &exit/1, :aborted])
    start_workers(n-1, max_fac)
  end

  defp start_workers(n, max_fac) when is_integer(n) and n > 0 do
    spawn_link(ProcessExample, :worker, [self(), &Factorial.factorial/1, :rand.uniform(max_fac)])
    start_workers(n-1, max_fac)
  end

  defp start_workers(_, _) do
    exit("start_workers requires a positiv integer as argument")
  end

  def worker(home, func, n) do
    #IO.puts "started Worker with PID: #{self()}"
    result = func.(n)
    send(home, {result, self()})
    #IO.puts "sending result to #{home}"
  end

end