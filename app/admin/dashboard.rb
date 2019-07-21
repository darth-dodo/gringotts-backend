ActiveAdmin.register_page "Dashboard" do
  content do
    section "Your current account summary" do
      table_for current_user.accounts do |a|
        a.column("Name") { |account| link_to account.name, admin_account_path(account) }
        a.column("Current Balance") { |account| account.current_value }
      end
    end

    section "Your last 10 transactions" do
      table_for current_user.expense_logs.order(created_at: :desc).first(10) do |current_log|
        current_log.column("Account") { |log| link_to log.account.name, admin_account_path(log.account) }
        current_log.column("Category") { |log| link_to log.category.name, admin_category_path(log.category) }
        current_log.column("Amount") { |log| log.amount }
        current_log.column("Mode") { |log| log.mode.humanize }
        current_log.column("Note") { |log| log.note }
        current_log.column("Created At") { |log| log.created_at }
      end
    end

    # section "Your Categorical Expense" do
    #   table_for current_user.expense_logs.group(:category_id).count do |current_cat|
    #     category_obj = Category.find(current_cat)
    #     binding.pry
    #     current_cat.column("Category") { |cat| link_to category_obj.name, admin_category_path(category_obj) }
    #   end
    # end

  end

  # section "Tasks that are late" do
  #   table_for current_admin_user.tasks.where('due_date < ?', Time.now) do |t|
  #     t.column("Status") { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
  #     t.column("Title") { |task| link_to task.title, admin_task_path(task) }
  #     t.column("Assigned To") { |task| task.admin_user.email }
  #     t.column("Due Date") { |task| task.due_date? ? l(task.due_date, :format => :long) : '-' }
  #   end
  # end

end