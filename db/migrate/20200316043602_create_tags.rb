class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :tags_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :tag
    end
  end
end
