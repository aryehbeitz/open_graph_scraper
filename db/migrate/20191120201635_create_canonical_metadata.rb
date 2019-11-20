class CreateCanonicalMetadata < ActiveRecord::Migration[6.0]
  def change
    create_table :canonical_metadata do |t|
      t.json :metadata
      t.references :canonical_token

      t.timestamps
    end
  end
end
