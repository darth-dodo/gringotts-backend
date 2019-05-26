module InternalTransferLogServices
  class RegisterInternalTransfer < ApplicationService

    def initialize(context)
=begin
      context = {
          expense_log_id: expense_log_id,
          destination_account_id: destination_account_id
      }
=end

      super()
      @context = Hashie::Mash.new(context)

      @expense_log = ExpenseLog.find(@context.expense_log_id)
      @destination_account = Account.find(@context.destination_account_id)

      @new_internal_transfer_log = InternalTransferLog.new

    end

    def call
      validate
      return unless valid?

      ActiveRecord::Base.transaction do
        execute_expense_log_creation_service
        rollback_database_transaction_if_invalid

        create_internal_transfer_expense_log
        rollback_database_transaction_if_invalid
      end

      valid?
    end

    protected
    def validate
      expense_log_has_existing_internal_transfer_attached?
      validate_source_and_destination_user
    end

    private
    def expense_log_has_existing_internal_transfer_attached?
      if @expense_log.internal_transfer_log.present?
        error 'Expense log already register across internal transfer!'
      end
    end

    def validate_source_and_destination_user
      unless @destination_account.user == @expense_log.account.user
        error 'Destination account does not belong to the user!'
      end
    end

    def set_internal_transfer_category_id
      user_internal_transfer_category = @expense_log.user.categories.internal_transfer
      user_internal_transfer_category.try(:id)
    end

    def create_expense_log_params
      expense_log_params = Hash.new
      expense_log_params[:user_id] = @destination_account.user_id
      expense_log_params[:account_id] = @destination_account.id
      # todo(juneja): discuss this with nagekar
      expense_log_params[:category_id] = set_internal_transfer_category_id
      expense_log_params[:amount] = @expense_log.amount
      expense_log_params[:mode] = :credit

      expense_log_params
    end

    def execute_expense_log_creation_service
      expense_log_creation_service = ExpenseLogServices::CreateExpenseLog.new(create_expense_log_params)
      unless expense_log_creation_service.call
        error expense_log_creation_service.errors
      end
    end

    def create_internal_transfer_expense_log
      @new_internal_transfer_log
    end

  end
end