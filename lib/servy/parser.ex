defmodule Servy.Parser do

  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")
    [request| header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request)

    headers = parse_headers(header_lines)
    params = parse_params(headers["Content-Type"], params_string)

    %Conv{method: method, path: path, params: params, header: headers}
  end

  defp parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim |> URI.decode_query
  end

  defp parse_params(_, _), do: %{}

  defp parse_headers(header_lines) do
    Enum.reduce(header_lines, %{}, &insert_header(&1, &2))
  end

  defp insert_header(new_header_string, headers) do
    [key, value] = String.split(new_header_string, ": ")
     Map.put(headers, key, value)
  end
end
