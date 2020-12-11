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
FactoryBot.define do
  factory :tweet do
    
  end
end
