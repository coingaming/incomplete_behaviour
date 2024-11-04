# IncompleteBehaviour

A small library to write partial implementations of behaviours **without warnings**.
Exercise care when using.

This was implemented for the use-case of `Mox` stubs, where modules need to
implement the mocked behaviour. Sometimes, we wanted to use modules as stubs,
but without implementing all functions.

## Installation

This library is available on Hex. Add to your deps:

```elixir
{:incomplete_behaviour, "~> 1.0"}
```

## Usage

Simply add `use IncompleteBehaviour` in your module:

```elixir
defmodule MyModule do
    @behaviour MyBehaviour
    use IncompleteBehaviour
end
```
