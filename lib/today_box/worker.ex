defmodule TodayBox.Worker do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    schedule_job(0)
    {:ok, %{}}
  end

  def handle_info(:fetch, state) do
    fetch_data() |> print()
    schedule_job(1_000)
    {:noreply, state}
  end

  defp print(%{"totalBox" => money, "updateInfo" => time}) do
    IO.puts "今日票房：#{money}, #{time}"
    IO.puts "============================="
  end

  defp fetch_data do
    "https://box.maoyan.com/promovie/api/box/second.json"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Map.get("data")
    |> Map.take(["totalBox", "updateInfo"])
  end

  defp schedule_job(interval) do
    Process.send_after(__MODULE__, :fetch, interval)
  end
end
