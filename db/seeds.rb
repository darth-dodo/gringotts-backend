# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_seed_users
  User.create!([
                   {
                       email: 'admin@gringotts.com',
                       password: "get_rich_or_die_codin"
                   },
                   {
                       email: 'demo@gringotts.com',
                       password: "demodemodemodemodemodemodemo"
                   }
               ])
end

def fetch_admin_user
  User.find_by_email('admin@gringotts.com')
end

def create_creditable_categories

  admin_user = fetch_admin_user
  return if admin_user.blank?

  Category.create!([
                       {
                           name: 'Salary',
                           user: admin_user,
                           eligible_mode: :creditable
                       },
                       {
                           name: 'Gift',
                           user: admin_user,
                           eligible_mode: :creditable
                       },
                       {
                           name: 'Bonus',
                           user: admin_user,
                           eligible_mode: :creditable
                       }
                   ])
end

def create_debitable_categories
  admin_user = fetch_admin_user
  return if admin_user.blank?

  Category.create!([
                       {
                           name: 'Commute',
                           user: admin_user,
                           eligible_mode: :debitable
                       },
                       {
                           name: 'Food',
                           user: admin_user,
                           eligible_mode: :debitable
                       },
                       {
                           name: 'Recreation',
                           user: admin_user,
                           eligible_mode: :debitable
                       },
                       {
                           name: 'Internal Transfer',
                           user: admin_user,
                           eligible_mode: :debitable
                       },

                   ])

end

def create_dummy_accounts
  admin_user = fetch_admin_user
  return if admin_user.blank?

  Account.create!([
                      {
                          user: admin_user,
                          current_value: 1000,
                          name: "Salary"
                      },
                      {
                          user: admin_user,
                          current_value: 100,
                          name: "Savings"
                      },
                      {
                          user: admin_user,
                          current_value: 100,
                          name: "Cash"
                      }

                  ])

end

def create_seed_transfer_expense_log
  eager_loaded_user = User.includes(:categories, :accounts).first
  eager_loaded_user_categories = eager_loaded_user.categories
  eager_loaded_user_accounts = eager_loaded_user.accounts
  salary_account = eager_loaded_user_accounts.for_slug('salary').first

  seed_expense_log = ExpenseLog.new
  seed_expense_log.user = eager_loaded_user
  seed_expense_log.category = eager_loaded_user_categories.for_slug('salary').first
  seed_expense_log.account = salary_account
  seed_expense_log.amount = 10000
  seed_expense_log.mode = :credit
  seed_expense_log.save

end

def create_internal_transfer_expense_log
  eager_loaded_user = User.includes(:categories, :accounts).first
  eager_loaded_user_categories = eager_loaded_user.categories
  eager_loaded_user_accounts = eager_loaded_user.accounts
  internal_transfer_category = eager_loaded_user_categories.internal_transfer
  salary_account = eager_loaded_user_accounts.for_slug('salary').first

  new_expense_log = ExpenseLog.new
  new_expense_log.user = eager_loaded_user
  new_expense_log.account = salary_account
  new_expense_log.category = internal_transfer_category
  new_expense_log.amount = 100
  new_expense_log.mode = :debit
  new_expense_log.save
end

if Rails.env.development?

  ActiveRecord::Base.transaction do
    create_seed_users
    create_creditable_categories
    create_debitable_categories
    create_dummy_accounts
    create_seed_transfer_expense_log
    create_internal_transfer_expense_log
  end

end

