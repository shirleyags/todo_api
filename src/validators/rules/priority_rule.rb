class PriorityRule
  VALID_PRIORITIES = %w[low medium high].freeze

  def self.validate(payload)
    priority = payload[:priority]
    return [] unless priority

    return [] if VALID_PRIORITIES.include?(priority)

    ['priority must be low, medium or high']
  end
end