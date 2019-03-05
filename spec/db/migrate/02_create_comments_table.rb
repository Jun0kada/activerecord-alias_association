class CreateCommentsTable < (ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration)
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :body
    end
  end
end
