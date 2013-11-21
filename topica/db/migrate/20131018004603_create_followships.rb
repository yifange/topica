class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.references :user, index: true
      t.references :topic, index: true
      t.references :feed, index: true

      t.timestamps
    end
  end
end
