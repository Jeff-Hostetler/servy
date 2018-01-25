defmodule Servy.BearController do

  alias Servy.Conv
  alias Servy.Bear
  alias Servy.WildThings


  def index(%Conv{} = conv) do
    response_body =
      WildThings.list_bears
      |> Enum.filter(&Bear.is_grizzly?(&1))
      |> Enum.sort(&Bear.order_asc_by_name(&1, &2))
      |> Enum.map(&bear_item(&1))
      |> Enum.join

    %{conv | resp_body: "<ul>#{response_body}</ul>", status: 200}
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    bear = WildThings.get_bear(id)

    %{conv | resp_body: "<h1>Bear #{bear.name}</h1>", status: 200}
  end

  def create(%Conv{} = conv, %{"name" => name, "type" => type}) do
    %{conv | resp_body: "Created a #{name} bear named #{type}", status: 201}
  end

  def delete(%Conv{} = conv, %{"id" => id}) do
    %{conv | resp_body: "Do not delete bears", status: 403}
  end

  defp bear_item(%Bear{} = bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end
end
