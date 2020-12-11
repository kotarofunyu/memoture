# == Schema Information
#
# Table name: scrapings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Scraping < ApplicationRecord
  require 'mechanize'
  def self.scrape
    agent = Mechanize.new
    page = agent.get("")
    elements = page.search('article[]')
    elements.each do |element|
      memo = Memo.new
      memo.text = element.inner_text
      memo.save
    end
  end
end
