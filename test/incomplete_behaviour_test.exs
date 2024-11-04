defmodule IncompleteBehaviourTest do
  use ExUnit.Case
  doctest IncompleteBehaviour

  defmodule MyBehaviour do
    @callback hello() :: String.t()
    @callback world(String.t()) :: String.t()
  end

  test "allows incomplete behaviours" do
    defmodule TestA do
      use IncompleteBehaviour
      @behaviour MyBehaviour

      def world(a), do: a
    end

    assert_raise UndefinedFunctionError, fn ->
      TestA.hello()
    end

    assert TestA.world("hello") == "hello"
  end
end
