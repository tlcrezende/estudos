class CreateResumes < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes do |t|
      t.references :chat, null: false, foreign_key: true
      t.integer :years_of_experience, default: 0
      t.string :favorite_programming_language, default: 'Não informado ou não capturado'
      t.boolean :willing_to_work_onsite, default: false
      t.boolean :willing_to_use_ruby, default: false
      t.string :interview_date, default: 'Não informado ou não capturado'

      t.timestamps
    end
  end
end
