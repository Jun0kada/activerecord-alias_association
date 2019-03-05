class CreateTeamsTable < (ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration)
  def change
    create_table :teams do |t|
      t.string :name
    end
  end
end
