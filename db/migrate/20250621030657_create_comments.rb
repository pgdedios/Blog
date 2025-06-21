class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :commenter, null: false
      t.text :body
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
