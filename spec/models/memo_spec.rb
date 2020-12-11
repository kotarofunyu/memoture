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
require 'rails_helper'

RSpec.describe Memo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
