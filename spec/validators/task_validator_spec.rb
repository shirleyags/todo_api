require_relative '../../src/validators/task_validator'

RSpec.describe TaskValidator do
  describe '.validate_create' do

    it 'returns error when title is missing' do
      result = described_class.validate_create({})

      expect(result).to include('title is required')
    end

    it 'returns error when priority is invalid' do
      result = described_class.validate_create(
        title: 'Estudar Ruby',
        priority: 'urgent'
      )

      expect(result).to include('priority must be low, medium or high')
    end

    it 'returns empty array when payload is valid' do
      result = described_class.validate_create(
        title: 'Estudar Ruby',
        priority: 'high',
        status: 'pending',
        due_date: '2030-01-01'
      )

      expect(result).to eq([])
    end

  end
end