class CreateUsersTable < (ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration)
  def change
    create_table :users do |t|
      t.integer :team_id
      t.string :name
    end
  end
end
