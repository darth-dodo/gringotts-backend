class CreateInternalTransferLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :internal_transfer_logs do |t|
      t.references :source_account, null: false
      t.references :destination_account, null: false
      t.references :expense_log, index: true, null: false
      t.timestamps
    end
    add_foreign_key :internal_transfer_logs, :accounts, column: :source_account_id, primary_key: :id
    add_foreign_key :internal_transfer_logs, :accounts, column: :destination_account_id, primary_key: :id
    add_foreign_key :internal_transfer_logs, :expense_logs
  end
end
