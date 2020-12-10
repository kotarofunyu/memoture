# == Schema Information
#
# Table name: memos
#
#  id         :bigint           not null, primary key
#  text       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Memo < ApplicationRecord
  validates :text, presence: true
end
