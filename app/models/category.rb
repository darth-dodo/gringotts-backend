class Category < ApplicationRecord
=begin
name Commute, Food and Beverages
slug commmute, food-and-beverages
active
eligible_mode: [credit, debit] immutable
eg. {credit: [Gift, Income], debit: [“Booze”]}
=end

  belongs_to :user


end

