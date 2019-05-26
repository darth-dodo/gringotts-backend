module ExpenseLogServices
  class CreateExpenseLog < ApplicationService

    def initialize(context)
=begin

      u = User.first
      a = u.accounts.first
      c = u.categories.first

      context = {
                  user_id: u.id,
                  account_id: a.id,
                  category_id: c.id,
                  amount: 5500,
                  mode: 1,
                  note: "NA"
                }
      expense_log_service = ExpenseLogServices::CreateExpenseLog.new(context)
      expense_log_service.call

      u = User.first
      a = u.accounts.first
      c = u.categories.first
      da = u.accounts.for_slug('cash').first
      internal_transfer_cat = u.categories.internal_transfer.try(:id)

      context = {
                  user_id: u.id,
                  account_id: a.id,
                  category_id: internal_transfer_cat,
                  amount: 50,
                  mode: 1,
                  note: "NA",
                  destination_account_id: da.id
                }

      expense_log_service = ExpenseLogServices::CreateExpenseLog.new(context)
      expense_log_service.call

=end
      super()
      @context = Hashie::Mash.new(context)

      # find_by returns nil if object is not present
      # find raise RecordNotFound
      # todo(juneja) add global error handle to handle 404
      @account = Account.find(@context.account_id)
      @category = Category.find(@context.category_id)
      # todo(juneja) implement current user from request store
      @user = User.find(@context.user_id)

      @amount = @context.amount
      @mode = @context.mode
      @note = @context.note

      @destination_account_id = @context.destination_account_id
      @is_internal_transfer = @destination_account_id.present?

      @new_expense_log = ExpenseLog.new
    end

    def call

      # https://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html
      ActiveRecord::Base.transaction do
        create_expense_log
        rollback_database_transaction_if_invalid

        # account operations
        execute_update_account_service
        rollback_database_transaction_if_invalid

        # internal transfer operations
        if @is_internal_transfer
          execute_internal_transfer_registration_service
          rollback_database_transaction_if_invalid
        end
      end #transaction commit

      valid?

    end

    private

    def create_expense_log
      @new_expense_log.user = @user
      @new_expense_log.category = @category
      @new_expense_log.account = @account
      @new_expense_log.amount = @amount
      @new_expense_log.mode = @mode
      @new_expense_log.note = @note

      unless @new_expense_log.save
        error @new_expense_log.errors.full_messages
      end
      @new_expense_log
    end

    def update_user_account_service_params
      {
          request_user:  @user.id,
          expense_log_id: @new_expense_log.id
      }
    end

    def execute_update_account_service
      update_user_account_service = AccountServices::UpdateCurrentValueForAccount.new(update_user_account_service_params)
      unless update_user_account_service.call
        error update_user_account_service.errors
      end
    end

    def internal_transfer_log_service_params
      {
          expense_log_id: @new_expense_log.id,
          destination_account_id: @destination_account_id
      }
    end

    def execute_internal_transfer_registration_service
      register_internal_transfer_service = InternalTransferLogServices::RegisterInternalTransfer.new(internal_transfer_log_service_params)

      unless register_internal_transfer_service.call
        error register_internal_transfer_service.errors
      end
    end

  end # service
end