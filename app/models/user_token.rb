# == Schema Information
# Schema version: 20101229093948
#
# Table name: user_tokens
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UserToken < ActiveRecord::Base
  belongs_to :user
end
