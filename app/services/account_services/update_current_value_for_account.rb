module AccountServices
  class UpdateCurrentValueForAccount < ApplicationService
=begin
  {
    expense_log_id: <expense_log_id>,
    request_user: <user_id>
  }
=end

    def initialize(context)
      super()
      @context = Hashie::Mash.new(context)
      @expense_log = ExpenseLog.find(@context.expense_log_id)
      @modified_by = User.find(@context.request_user)
      @account = @expense_log.account
      @amount = @expense_log.amount
    end

    def call
      update_account_value
      valid?
    end

    private
    def update_account_value
      if @expense_log.credit?
        @account.current_value += @expense_log.amount
      else
        @account.current_value -= @expense_log.amount
      end

      unless @account.save
        error @account.errors.full_messages
      end

    end

  end
end
