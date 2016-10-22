class CreateImages < ActiveRecord::Migration
  def change
    create_table "contributions", force: :cascade do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
      t.string :img
    end
  end
end
