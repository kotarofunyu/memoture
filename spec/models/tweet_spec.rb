# == Schema Information
#
# Table name: tweets
#
#  id               :bigint           not null, primary key
#  tweet_created_at :datetime
#  url              :string(255)
#  user_name        :string(255)
#  user_screen_name :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  memo_id          :integer
#
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
