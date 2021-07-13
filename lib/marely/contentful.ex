defmodule Marely.Contentful do
  import Contentful.Query
  alias Contentful.Delivery.Entries

  def get_recipies() do
    Entries|>content_type("recipe")|>include(2)|>fetch_all()
  end
end
