class CreateKeyword < ActiveRecord::Migration[8.1]
  def change
    create_table :keywords do |t|
      t.references :keyword_file, null: false, foreign_key: true
      t.string :keyword, null: false
      t.string :status

      t.timestamps
    end
  end
end
