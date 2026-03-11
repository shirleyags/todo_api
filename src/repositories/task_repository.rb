require_relative '../../config/mongo'
require_relative '../models/task'

class TaskRepository
  def self.create(task)
    TASKS_COLLECTION.insert_one(task.to_h)
    task
  end

  def self.find_by_id(id)
    document = TASKS_COLLECTION.find(id: id).first
    return nil unless document

    build_task(document)
  end

  def self.build_task(document)
    Task.new(
      id: document[:id],
      title: document[:title],
      description: document[:description],
      status: document[:status],
      priority: document[:priority],
      due_date: document[:due_date],
      created_at: document[:created_at],
      updated_at: document[:updated_at]
    )
  end

  def self.find_all
    TASKS_COLLECTION.find.map do |document|
      build_task(document)
    end
  end

  def self.update(id, updates)
    allowed_fields = [:title, :description, :status, :priority, :due_date, :updated_at]

    safe_updates = updates.slice(*allowed_fields)

    TASKS_COLLECTION.update_one(
      {id: id},
      { '$set' => safe_updates}
    )

    find_by_id(id)
  end

  def self.delete(id)
    TASKS_COLLECTION.delete_one({ id: id })
  end
end