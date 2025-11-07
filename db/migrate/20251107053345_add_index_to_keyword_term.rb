class AddIndexToKeywordTerm < ActiveRecord::Migration[8.1]
  def change
    add_index :keywords, :term
  end
end
