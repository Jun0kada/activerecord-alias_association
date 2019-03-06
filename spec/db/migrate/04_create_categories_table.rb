class CreateCategoriesTable < (ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration)
  def change
    create_table :categories do |t|
      t.string :name
    end
  end
end
