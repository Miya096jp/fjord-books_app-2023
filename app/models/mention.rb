class Mention < ApplicationRecord
  belongs_to :mention, class_name: "Report"
  belongs_to :mentioned, class_name: "Report"
end
