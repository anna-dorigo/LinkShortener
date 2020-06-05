class AddStateToLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :state, :boolean, default: true
  end
end
