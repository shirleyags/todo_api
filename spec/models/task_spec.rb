require_relative '../../src/models/task'

RSpec.describe Task do

  it 'sets default status to pending' do
    task = described_class.new(
      id: '1',
      title: 'Estudar Ruby'
    )

    expect(task.status).to eq('pending')
  end

  it 'sets default priority to medium' do
    task = described_class.new(
      id: '1',
      title: 'Estudar Ruby'
    )

    expect(task.priority).to eq('medium')
  end

  it 'returns true when task is completed' do
    task = described_class.new(
      id: '1',
      title: 'Estudar Ruby',
      status: 'completed'
    )

    expect(task.completed?).to be true
  end

end