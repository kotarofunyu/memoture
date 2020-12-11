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
class Memo < ApplicationRecord
  has_one :tweet, dependent: :destroy
  validates :text, presence: true
  enum from: { twitter: 0 }
end
