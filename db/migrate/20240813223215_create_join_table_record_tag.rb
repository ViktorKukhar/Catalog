class CreateJoinTableRecordTag < ActiveRecord::Migration[7.1]
  def change
    create_join_table :records, :tags do |t|
       t.index [:record_id, :tag_id]
       t.index [:tag_id, :record_id]
    end
  end
end
