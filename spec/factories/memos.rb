# == Schema Information
#
# Table name: memos
#
#  id         :bigint           not null, primary key
#  from       :integer
#  text       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :memo do
    
  end
end
