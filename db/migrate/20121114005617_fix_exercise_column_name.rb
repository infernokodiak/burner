class FixExerciseColumnName < ActiveRecord::Migration
  def up
    rename_column :exercises, :type, :activity_type
  end

  def down
  end
end
