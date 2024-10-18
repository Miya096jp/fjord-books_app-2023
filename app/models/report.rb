# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mention_relationships, class_name: 'Mention',
                                   foreign_key: 'mention_id',
                                   dependent: :destroy,
                                   inverse_of: :mention
  has_many :mentioning_reports, through: :mention_relationships, source: :mentioned
  has_many :mentioned_in_relationships, class_name: 'Mention',
                                        foreign_key: 'mentioned_id',
                                        dependent: :destroy,
                                        inverse_of: :mentioned
  has_many :mentioned_reports, through: :mentioned_in_relationships, source: :mention

  validates :title, presence: true
  validates :content, presence: true
  validate :no_self_mention

  REPORT_URL_PATTERN = %r{http://localhost:3000/reports/(\d+)}

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def extract_mentions
    content.scan(REPORT_URL_PATTERN).flatten.uniq
  end

  def update_mentions!
    mention_relationships.destroy_all
    mentions = extract_mentions
    mentions.each do |mention_id|
      Mention.create!(mention_id: id, mentioned_id: mention_id)
    end
  end

  private

  def no_self_mention
    mentions = extract_mentions
    return if mentions.exclude?(id.to_s)

    errors.add(:base, 'この日報自身に言及することはできません')
  end
end
