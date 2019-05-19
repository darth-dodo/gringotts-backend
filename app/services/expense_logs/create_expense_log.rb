module ExpenseLogs
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
                  amount: 10000,
                  mode: 1,
                  note: "NA"
                }
      expense_log_service = ExpenseLogs::CreateExpenseLog.new(context)
      expense_log_service.call
=end
      super()
      @context = Hashie::Mash.new(context)

      # find_by returns nil if object is not present
      # find raise RecordNotFound
      # todo(juneja) change this to find once we have a global error handler
      @account = Account.find_by(id: @context.account_id)
      @category = Category.find_by(id: @context.category_id)
      # todo(juneja) implement current user from request store
      @user = User.find_by(id: @context.user_id)

      @amount = @context.amount
      @mode = @context.mode
      @note = @context.note

      @is_internal_transfer = @context.is_internal_transfer
      @new_expense_log = ExpenseLog.new
    end

    def call

      # https://api.rubyonrails.org/classes/ActiveRecord/Transactions/ClassMethods.html
      ActiveRecord::Base.transaction do
        create_expense_log
        return unless valid?

        # account operations
        update_user_account
        unless valid?
          rollback_database_transaction
          return valid?
        end

        # internal transfer operations
        if @is_internal_transfer
          register_internal_transfer
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

    def update_user_account
      puts "updating the user account"
    end

    def register_internal_transfer
      puts "registering internal transfer"
    end

    def rollback_database_transaction
      unless valid?
        puts "rolling back since errors are present!"
        raise ActiveRecord::Rollback
      end
    end

  end # service
end