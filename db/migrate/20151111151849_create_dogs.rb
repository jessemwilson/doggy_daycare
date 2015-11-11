class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.references :breed, index: true, foreign_key: true
      t.references :owner, index: true, foreign_key: true
      t.string :med_cond
      t.string :vet
      t.date :dob

      t.timestamps null: false
    end
  end
end
