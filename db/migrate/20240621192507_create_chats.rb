class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.string :questions_and_answers, array: true, default: []
      t.text :prompt, default: '', null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
