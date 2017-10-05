class CreateCompaniesTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :companies_tasks do |t|
      t.integer :company_id
      t.integer :task_id
    end
  end
end
