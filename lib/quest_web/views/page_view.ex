defmodule QuestWeb.PageView do
  use QuestWeb, :view
  def topic_index(row_index, index) do
    row_index * 3 + index
  end
end
