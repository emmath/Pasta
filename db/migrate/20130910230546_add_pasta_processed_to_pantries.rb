class AddPastaProcessedToPantries < ActiveRecord::Migration
  def change
    add_column :pantries, :pasta_processed, :boolean
  end
end
