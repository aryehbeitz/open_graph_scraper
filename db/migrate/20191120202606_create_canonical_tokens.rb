class CreateCanonicalTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :canonical_tokens do |t|
      t.string :token, null: false, index: { unique: true }
      t.string :canonical_url

      t.timestamps
    end
  end
end
