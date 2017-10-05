class ChangeMaxcountTypeInCompanies < ActiveRecord::Migration[5.1]
  def change
    change_column :companies, :maxcount, :integer
  end
end
