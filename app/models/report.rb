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

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def no_self_mention
    report_url_pattern = %r{http://localhost:3000/reports/(\d+)}
    mentions = content.scan(report_url_pattern).flatten

    return unless mentions.include?(id.to_s)

    errors.add(:base, 'この日報自身に言及することはできません')
  end
end
