defmodule Quest.ExAdmin.Topic do
  use ExAdmin.Register

  register_resource Quest.Web.Topic do
    index do
      selectable_column()
      column :id
      column :name
      column "Avatar", &(img(src: Quest.Avatar.url({&1.avatar, &1}, :original), height: 100, width: 100))
      actions()
    end
    show _topic do

      attributes_table do
        row :name
        row "Avatar", &(img(src: Quest.Avatar.url({&1.avatar, &1}, :thumb)))
      end  # display the defaults attributes
    end
  end
end
