defmodule Nostrum.Struct.Message.Sticker do
  @moduledoc """
  Struct representing a Discord message sticker.
  """
  alias Nostrum.{Snowflake, Util}

  defstruct [
    :asset,
    :description,
    :format_type,
    :id,
    :name,
    :pack_id,
    :preview_asset,
    :tags
  ]

  @typedoc "Sticker asset hash. The url for fetching the sticker assets is currently private."
  @type asset :: String.t()

  @typedoc "Description of the sticker"
  @type description :: Stirng.t()

  @typedoc "[type of sticker format](https://discord.com/developers/docs/resources/channel#message-object-message-sticker-format-types)"
  @type format_type :: integer()

  @typedoc "id of the sticker"
  @type id :: Snowflake.t()

  @typedoc "name of the sticker"
  @type name :: String.t()

  @typedoc "id of the pack the sticker is from"
  @type pack_id :: Snowflake.t()

  @typedoc "Sticker preview asset hash. The url for fetching the sticker assets is currently private."
  @type preview_asset :: String.t()

  @typedoc "List of the tags for the sticker"
  @type tags :: [String.t()] | nil

  @type t :: %__MODULE__{
          asset: asset(),
          description: description(),
          format_type: format_type(),
          id: id(),
          name: name(),
          pack_id: pack_id(),
          preview_asset: preview_asset(),
          tags: tags()
        }

  @doc false
  def to_struct(map) do
    new =
      map
      |> Map.new(fn {k, v} -> {Util.maybe_to_atom(k), v} end)
      |> Map.update(:id, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:pack_id, nil, &Util.cast(&1, Snowflake))
      |> Map.update(:tags, nil, &String.split(&1, ",", trim: true))

    struct(__MODULE__, new)
  end
end
