class Task
  attr_reader :id, :title, :description, :status, :priority, :due_date, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @status = attributes[:status] || 'pending'
    @priority = attributes[:priority] || 'medium'
    @due_date = attributes[:due_date]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def completed?
    status == 'completed'
  end

  def to_h
    {
      id: id,
      title: title,
      description: description,
      status: status,
      priority: priority,
      due_date: due_date,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end