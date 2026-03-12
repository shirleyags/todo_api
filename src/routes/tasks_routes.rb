require 'sinatra/base'
require 'json'
require 'time'

require_relative '../repositories/task_repository'
require_relative '../services/task_service'
require_relative '../support/response_helper'
require_relative '../validators/task_validator'

class TasksRoutes < Sinatra::Base
  helpers ResponseHelper

  before do
    content_type :json
  end

  post '/tasks' do
    payload = JSON.parse(request.body.read, symbolize_names: true)

    result = TaskService.create(payload)

    return error_response('validation_failed', 400, result[:errors]) if result.is_a?(Hash) && result[:errors]

    json_response(result.to_h, 201)
  end

  get '/tasks' do
    tasks = TaskRepository.find_all
    json_response(tasks.map(&:to_h))
  end

  get '/tasks/:id' do
    task = TaskRepository.find_by_id(params[:id])
    return error_response('task not found', 404) if task.nil?

    json_response(task.to_h)
  end

  patch '/tasks/:id' do
    payload = JSON.parse(request.body.read, symbolize_names: true)

    task = TaskRepository.find_by_id(params[:id])
    return error_response('task not found', 404) if task.nil?
    return error_response('completed tasks cannot be edited', 400) if task.completed?

    merged_payload = {
      title: payload.key?(:title) ? payload[:title] : task.title,
      description: payload.key?(:description) ? payload[:description] : task.description,
      status: payload.key?(:status) ? payload[:status] : task.status,
      priority: payload.key?(:priority) ? payload[:priority] : task.priority,
      due_date: payload.key?(:due_date) ? payload[:due_date] : task.due_date
    }

    errors = TaskValidator.validate_create(merged_payload)
    return error_response('validation_failed', 400, errors) if errors.any?

    payload[:updated_at] = Time.now.utc.iso8601

    updated_task = TaskRepository.update(params[:id], payload)
    json_response(updated_task.to_h)
  end

  delete '/tasks/:id' do
    result = TaskRepository.delete(params[:id])
    return error_response('task not found', 404) if result.deleted_count == 0

    status 204
    body nil
  end

  get '/health' do
    json_response({ status: 'ok' })
  end
end