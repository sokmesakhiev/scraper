class CreateKeyword < ActiveRecord::Migration[8.1]
  def change
    create_table :keywords do |t|
      t.references :keyword_file, null: false, foreign_key: true
      t.string :term, null: false
      t.integer :total_ads
      t.integer :total_link
      t.text    :html_code
      t.string :status

      t.timestamps
    end
  end
end
