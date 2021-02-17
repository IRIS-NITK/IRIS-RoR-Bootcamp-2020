class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :tags
      t.string :topic
      t.string :content

      t.timestamps
    end
  end
end
