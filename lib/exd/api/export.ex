defmodule Exd.Api.Export do

  defmacro __using__(opts) do
    models = opts[:models] || raise ArgumentError, message: "Export Api should have `models` in options"
    service = opts[:service] || raise ArgumentError, message: "Export Api should have `service` in options"
    repo = opts[:repo] || raise ArgumentError, message: "Export Api should have `repo` in options"
    quote do
      use Apix
      import Exd.Plugin.Hello, only: :macros
      @name "Export"
      @tech_name "export"
      @moduledoc "Export api"

      api "post", :__post__
      api "options", :__options__

      def_service unquote(service)

      @doc """
      Method: `post`.
      Export all data from an application

      ## Parameters

      * `:models` - list, optional, a list of models to be exported

      """
      def __post__(args), do: Ecto.Export.export(unquote(repo), unquote(models), args)

      @doc """
      Method: `options`.
      Provides introspection for the Export API.

      ## Parameters

      ## Results

      """
      def __options__(_args), do: Exd.Api.Export.introspection(__MODULE__)
    end
  end

  def introspection(api) do
    %{name:        Apix.spec(api),
      desc_name:   Apix.spec(api, :name),
      description: Apix.spec(api, :doc),
      methods:     Apix.spec(api, :methods),
      fields:      []}
  end

end


