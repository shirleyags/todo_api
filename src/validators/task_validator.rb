require_relative 'rules/title_required_rule'
require_relative 'rules/title_length_rule'
require_relative 'rules/priority_rule'
require_relative 'rules/due_date_rule'

class TaskValidator
  RULES = [
    TitleRequiredRule,
    TitleLengthRule,
    PriorityRule,
    DueDateRule
  ]

  def self.validate_create(payload)
    RULES.flat_map { |rule| rule.validate(payload) }
  end
end