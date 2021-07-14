defmodule Marely.Recipe do
  def image(%{"photo" => %{"file" => %{"url" => url}, "title" => title}}) do
    %{title: title, url: url}
  end

  def image(_recipe) do
    %{title: nil, url: nil}
  end
end
