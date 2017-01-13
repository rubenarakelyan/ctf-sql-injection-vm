class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string   'title', null: false
      t.text     'body', null: false
      t.integer  'user_id', null: false
      t.timestamps
    end

    create_table :users do |t|
      t.string   'name', null: false
      t.timestamps
    end
  end
end
