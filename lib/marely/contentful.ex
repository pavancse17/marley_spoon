defmodule Marely.Contentful do
  def get_recipies() do
    HTTPoison.get!("https://cdn.contentful.com/spaces/kk2bw5ojx476/environments/master/entries?access_token=7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c&content_type=recipe")
    |>parse_body()
  end

  defp parse_body(%HTTPoison.Response{} = resonse) do
    Jason.decode!(resonse.body)
    |>map_data()
  end

  defp map_data(%{"items" => items, "includes" => includes}) do
    IO.inspect(items)
  end
end
