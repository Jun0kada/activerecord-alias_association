class CreateImagesTable < (ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration)
  def change
    create_table :images do |t|
      t.integer :imageable_id
      t.string :imageable_type
    end
  end
end
