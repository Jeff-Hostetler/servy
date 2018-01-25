defmodule Servy.Bear do
  alias Servy.Bear

  defstruct id: nil, name: "", type: "", hibernating: false

  def is_grizzly?(%Bear{} = bear) do
    bear.type == "Grizzly"
  end

  def order_asc_by_name(%Bear{} = bear1, %Bear{} = bear2) do
    bear1.name <= bear2.name
  end
end
