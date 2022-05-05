class AddIsDeletedToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :nickname, :string
    add_column :customers, :sex, :integer
    add_column :customers, :birthday, :string
    add_column :customers, :introduction, :string
    add_column :customers, :telephon_number, :string
    add_column :customers, :is_deleted, :boolean, default: false
  end
end
