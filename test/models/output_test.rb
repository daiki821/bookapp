# == Schema Information
#
# Table name: outputs
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  task_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_outputs_on_task_id  (task_id)
#  index_outputs_on_user_id  (user_id)
#
require 'test_helper'

class OutputTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
