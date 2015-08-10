require 'spec_helper'
require 'cell'

describe 'Cell' do
  let(:world) { World.new(20, 20) }

  context 'cell utility methods' do
    subject { Cell.new(world) }

    it 'spawn relative to' do
      cell = subject.spawn_at(3, 5)
      expect(cell.is_a?(Cell)).to eq true
      expect(cell.x).to eq 3
      expect(cell.y).to eq 5
    end

    it 'detects a neighbour to the north' do
      subject.spawn_at(0, 1)
      expect(subject.neighbours.count).to eq 1
    end

    it 'detects a neighbour to the north east' do
      subject.spawn_at(1, 1)
      expect(subject.neighbours.count).to eq 1
    end

    it 'detects a neighbour to the north west' do
      subject.spawn_at(-1, 1)
      expect(subject.neighbours.count).to eq 1
    end

    it 'detects a neighbour to the south west' do
      subject.spawn_at(-1, -1)
      expect(subject.neighbours.count).to eq 1
    end

    it 'detects a neighbour to the south east' do
      subject.spawn_at(1, -1)
      expect(subject.neighbours.count).to eq 1
    end

    it 'detects a neighbour to the east' do
      subject.spawn_at(1, 0)
      expect(subject.neighbours.count).to eq 1
    end

    it 'detects a neighbour to the west' do
      subject.spawn_at(- 1, 0)
      expect(subject.neighbours.count).to eq 1
    end

    it '#die!' do
      subject.die!
      expect(subject.world.new_cells).to_not include subject
    end

    it '#died_neighbours' do
      expect(subject.died_neighbours.count).to eq 8
    end
  end
end
