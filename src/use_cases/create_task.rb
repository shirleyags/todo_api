class CreateTask
  def self.call(payload)
    errors = TaskValidator.validate_create(payload)
    return { errors: errors } if errors.any?

    now = Time.now.utc.iso8601

    task = Task.new(
      id: SecureRandom.uuid,
      title: payload[:title]&.strip,
      description: payload[:description],
      status: payload[:status] || 'pending',
      priority: payload[:priority] || 'medium',
      due_date: payload[:due_date],
      created_at: now,
      updated_at: now
    )

    TaskRepository.create(task)
  end
end