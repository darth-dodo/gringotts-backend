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

def create_creditable_categories

  admin_user = User.find_by_email('admin@gringotts.com')
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
  admin_user = User.find_by_email('admin@gringotts.com')
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
                       }
                   ])

end

if Rails.env.development?

  ActiveRecord::Base.transaction do
    create_seed_users
    create_creditable_categories
    create_debitable_categories
  end

end

