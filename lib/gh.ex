defmodule GH do
  @moduledoc """
  A collection of modules to operate GitHub more easier.

  This library ported from [go-gh](https://github.com/cli/go-gh).
  """

  @doc """
  Exec the `gh` command with `args`.
  """
  def exec(args) when is_list(args) do
    with {:ok, gh_exe} <- path() do
      run(gh_exe, args)
    end
  end

  @doc """
  Returns `gh` executable path.
  """
  def path() do
    case System.get_env("GH_PATH") do
      nil ->
        case System.find_executable("gh") do
          nil -> {:error, :not_found}
          exe -> {:ok, exe}
        end

      exe ->
        {:ok, exe}
    end
  end

  defp run(gh_exe, args) do
    {output, exit_code} = System.cmd(gh_exe, args, stderr_to_stdout: true)

    case exit_code do
      0 -> {:ok, output}
      _non_zero -> {:error, output}
    end
  end
end
