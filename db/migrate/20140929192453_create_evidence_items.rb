class CreateEvidenceItems < ActiveRecord::Migration
  def change
    create_table :evidence_items do |t|
      t.string :title
      t.text :description
      t.belongs_to :submitter, index: true
      t.belongs_to :policy, index: true
      t.boolean :accepted, index: true
      t.integer :comments_count, default: 0, null: false

      t.integer :cached_votes_total,      default: 0, null: false, index: true
      t.integer :cached_votes_score,      default: 0, null: false, index: true
      t.integer :cached_votes_up,         default: 0, null: false, index: true
      t.integer :cached_votes_down,       default: 0, null: false, index: true
      t.integer :cached_weighted_score,   default: 0, null: false, index: true
      t.integer :cached_weighted_total,   default: 0, null: false, index: true
      t.integer :cached_weighted_average, default: 0, null: false, index: true

      t.timestamps
    end
  end
end
