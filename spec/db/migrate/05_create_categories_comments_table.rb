class CreateCategoriesCommentsTable < (ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration)
  def change
    create_table :categories_comments do |t|
      t.integer :comment_id
      t.integer :category_id
    end
  end
end
