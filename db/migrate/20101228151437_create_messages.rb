class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :body
      t.boolean :train
      t.integer :address_id
      t.integer :category_id
      t.integer :subject_id
      t.string  :assigned_category
      t.integer :user_id
      t.timestamps
    end
    add_index :messages, :address_id
  end

  def self.down
    drop_table :messages
  end
end

