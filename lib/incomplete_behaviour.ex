defmodule IncompleteBehaviour do
  @moduledoc """
  This module can be `use`d to implement partial behaviours.

  This was implemented for the use-case of `Mox` stubs, where modules need to
  implement the mocked behaviour. Sometimes, we wanted to use modules as stubs,
  but without implementing all functions.


  ### How it works?

  This library automatically implements all missing callbacks. Upon being called,
  these callbacks just raise UndefinedFunctionError.
  """

  @doc """
  Use this macro to make your module implement incomplete behaviours
  """
  defmacro __using__(_opts) do
    quote do
      @before_compile {IncompleteBehaviour, :before_compile}
      require IncompleteBehaviour
    end
  end

  @doc false
  defmacro before_compile(env) do
    functions_ast =
      env.module
      |> Module.get_attribute(:behaviour, [])
      |> Enum.flat_map(fn behaviour -> behaviour.behaviour_info(:callbacks) end)
      |> Enum.reject(fn {function, arity} ->
        Module.defines?(env.module, {function, arity}, :def)
      end)
      |> Enum.map(fn {function, arity} ->
        quote do
          IncompleteBehaviour.function_ast(unquote(function), unquote(arity))
        end
      end)

    quote do
      (unquote_splicing(functions_ast))
    end
  end

  @doc false
  defmacro function_ast(function_name, arity) do
    args =
      for i <- 1..arity//1 do
        Macro.var(:"_arg#{i}", __MODULE__)
      end

    quote do
      def unquote(function_name)(unquote_splicing(args)) do
        raise UndefinedFunctionError,
          module: __MODULE__,
          function: unquote(function_name),
          arity: unquote(arity)
      end
    end
  end
end
