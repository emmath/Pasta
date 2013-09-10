class AddPastaToPantries < ActiveRecord::Migration
  def change
    add_column :pantries, :pasta, :string
  end
end
