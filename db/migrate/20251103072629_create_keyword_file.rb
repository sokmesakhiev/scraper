class CreateKeywordFile < ActiveRecord::Migration[8.1]
  def change
    create_table :keyword_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, index: true, null: false
      t.string :original_file
      t.string :status

      t.timestamps
    end
  end
end
