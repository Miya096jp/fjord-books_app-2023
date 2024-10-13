# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mention, class_name: 'Report', inverse_of: :mention_relationships
  belongs_to :mentioned, class_name: 'Report', inverse_of: :mentioned_in_relationships
  validates :mention_id, uniqueness: { scope: :mentioned_id, message: 'すでに言及されています。' }
end
