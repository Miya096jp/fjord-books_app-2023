# frozen_string_literal: true

module ApplicationHelper
  # localeに応じて複数形の表記を変える
  # - 日本語の場合 => 本
  # - 英語の場合 => books
  def i18n_pluralize(word)
    I18n.locale == :ja ? word : word.pluralize
  end

  # localeに応じてエラー件数の表記を変える
  # - 日本語の場合 => 3件のエラー
  # - 英語の場合 => 3 errors
  def i18n_error_count(count)
    I18n.locale == :ja ? "#{count}件の#{t('views.common.error')}" : pluralize(count, t('views.common.error'))
  end

  def format_content(content)
    safe_join(content.split("\n"), tag.br)
  end

  def text_url_to_hyperlink(content)
    sanitized_content = sanitize(content)
    uri_reg = URI.regexp(%w[http https])
    return sanitized_content.gsub(uri_reg){"<a href='#{$&}' target='_blank'>#{$&}</a>"}
  end
end
