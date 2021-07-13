defmodule MarelyWeb.PageLive do
  use MarelyWeb, :live_view
  alias Marely.Contentful

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, recipes: Contentful.get_recipies())}
  end
end
