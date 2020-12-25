# == Schema Information
#
# Table name: recommends
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_recommends_on_user_id  (user_id)
#
class Recommend < ApplicationRecord
end
