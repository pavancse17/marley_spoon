defmodule Marely.Contentful do

  defp get_config(config_name) do
    Application.get_env(:marely, config_name)
  end

  defp get_base_url() do
    "https://cdn.contentful.com/spaces/#{get_config(:space_id)}/environments/#{get_config(:environment)}/entries?access_token=#{get_config(:access_token)}"
  end

  def get_recipies() do
    HTTPoison.get!("#{get_base_url()}&content_type=recipe")
    |>parse_response()
    |>Map.get(:data)
  end

  defp parse_response(%HTTPoison.Response{} = resonse) do
    Jason.decode!(resonse.body)
    |> parse_body()
    |> Map.delete(:entries)
    |> Map.delete(:assets)
  end

  defp parse_body(%{"items" => items, "includes" => %{"Entry" => entries, "Asset" => assets}}) do
    parse_data(items, %{entries: map_with_id(entries), assets: map_with_id(assets), data: []})
  end

  defp parse_data([ %{"fields" => fields} | remaining], acc) do
    element = Enum.into(fields, %{}, fn {key, value} ->
      {key, parase_field(value, acc)}
    end)
    parse_data(remaining, Map.update!(acc, :data, fn existing -> [element | existing] end))
  end

  defp parse_data([], acc) do
    acc
  end

  defp parase_field(%{ "sys" => %{"type" => "Link", "linkType" => "Asset", "id" => id}}, acc) do
    acc
    |>Map.get(:assets)
    |>Map.get(id)
  end

  defp parase_field(%{ "sys" => %{"type" => "Link", "linkType" => "Entry", "id" => id}}, acc) do
    acc
    |>Map.get(:entries)
    |>Map.get(id)
  end

  defp parase_field(field, acc) when is_list(field) do
    parse_list_field(field, [], acc)
  end

  defp parase_field(value, _acc) do
    value
  end

  defp parse_list_field([first | remaining], list_acc, acc) do
    parse_list_field(remaining, [parase_field(first, acc) | list_acc], acc)
  end

  defp parse_list_field([], list_acc, _acc) do
    list_acc
  end

  defp map_with_id(entries) do
    entries
    |>Enum.reduce(%{}, fn %{"sys" => %{"id" => id}, "fields" => fields}, acc ->
      Map.put(acc, id, fields)
    end)
  end
end
