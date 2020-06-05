class AddSlugToLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :slug, :string, :length => 10
  end
end
