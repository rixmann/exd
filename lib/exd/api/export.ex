defmodule Exd.Api.Export do

  defmacro __using__(opts) do
    models = opts[:models] || raise ArgumentError, message: "Export Api should have `models` in options"
    service = opts[:service] || raise ArgumentError, message: "Export Api should have `service` in options"
    quote do
      use Apix
      import Exd.Plugin.Hello, only: :macros
      @name "Export"
      @tech_name "export"
      @moduledoc "Export api"

      api "post", :__post__
      api "options", :__option__

      def_service unquote(service)

      @doc """
      Export all data from an application

      ## Parameters

      * `:models` - list, must be sent, a list of models to be exported

      ## Results

      """
      def __post__(args), do: Exd.Api.Export.post(args)

      @doc """
      Provides introspection for the Export API.

      ## Parameters

      ## Results

      """
      def __option__(_args), do: Exd.Api.Export.introspection(__MODULE__)
    end
  end

  def post(args), do: IO.puts(args)

  def introspection(api) do
    %{name:        Apix.spec(api),
      desc_name:   Apix.spec(api, :name),
      description: Apix.spec(api, :doc),
      methods:     Apix.spec(api, :methods),
      fields:      []}
  end

end


