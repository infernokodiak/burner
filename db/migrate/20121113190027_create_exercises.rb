class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :weight
      t.string :intensity
      t.string :type
      t.integer :calories

      t.timestamps
    end
  end
end
