class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :familyname
      t.string :firstname
      t.string :familyname_phonetic
      t.string :firstname_phonetic
      t.string :mail
      t.string :phone
      t.string :password_digest
      
      t.timestamps null: false
    end
  end
end
