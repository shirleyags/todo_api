class StatusRule
  VALID_STATUSES = ["pending", "in_progress", "completed", "cancelled"].freeze

  def self.validate(payload)
    status = payload[:status]
    return [] unless status
    return [] if VALID_STATUSES.include?(status)

    ['status must be pending, in_progress, completed or cancelled']
  end
end