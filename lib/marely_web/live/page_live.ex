defmodule MarelyWeb.PageLive do
  use MarelyWeb, :live_view
  alias Marely.Contentful
  import Marely.Recipe

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, recipes: Contentful.get_recipies())}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply,
     socket
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp apply_action(%{assigns: %{recipes: recipes}} = socket, :detail, %{"id" => id}) do
    socket
    |> assign(:recipe, Enum.at(recipes, String.to_integer(id)))
  end

  defp apply_action(socket, _, _params) do
    socket
  end
end
