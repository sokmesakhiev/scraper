class CreateKeywordResult < ActiveRecord::Migration[8.1]
  def change
    create_table :keyword_results do |t|
      t.references :keyword, null: false, foreign_key: true
      t.integer :total_ads
      t.integer :total_links
      t.text    :html_code

      t.timestamps
    end
  end
end
