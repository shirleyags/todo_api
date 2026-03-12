require 'date'

class DueDateRule
  def self.validate(payload)
    due_date = payload[:due_date]
    return [] unless due_date

    parsed_date = Date.iso8601(due_date.to_s)

    return ['due_date cannot be in the past'] if parsed_date < Date.today

    []
  rescue Date::Error
    ['due_date must be a valid ISO8601 date (YYYY-MM-DD)']
  end
end