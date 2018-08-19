defmodule TodayBox do
  def start do
    TodayBox.Worker.start_link()
  end
end
