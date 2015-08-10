require 'spec_helper'
require 'cell'
require 'died_cell'
require 'world'

describe 'Game of life' do
  let(:world) { World.new(20, 20) }

  it 'Rule #1 : Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
    cell = Cell.new(world)
    cell.spawn_at(2, 0)
    expect(cell.neighbours.count).to eq 0
    world.tick!
    expect(cell).to be_dead
  end

  it 'Rule #2 : Any live cell with two or three live neighbours lives on to the next generation.' do
    cell = Cell.new(world)
    new_cell = cell.spawn_at(1, 0)
    cell.spawn_at(2, 0)
    expect(new_cell.neighbours.count).to eq 2
    world.tick!
    expect(new_cell).to be_alive
  end

  it 'Rule #3 : Any live cell with more than three live neighbours dies, as if by overcrowding.' do
    cell = Cell.new(world, 2, 1)
    cell.spawn_at(1, 1)
    cell.spawn_at(3, 1)
    cell.spawn_at(2, 0)
    cell.spawn_at(2, 2)
    expect(cell.neighbours.count).to eq 4
    world.tick!
    expect(cell).to be_dead
  end

  it 'Rule #4 : Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.' do
    cell = Cell.new(world)
    cell.spawn_at(1, 0)
    cell.spawn_at(2, 0)
    world.tick!
    expect(world.cell_exists?(1, 1)).to eq true
  end

  context 'can generate an oscillator' do
    it 'phase 1' do
      cell = Cell.new(world, 0, 1)
      cell.spawn_at(1, 1)
      cell.spawn_at(2, 1)
      world.tick!
      expect(world.cell_exists?(1, 1)).to eq true
      expect(world.cell_exists?(1, 0)).to eq true
      expect(world.cell_exists?(1, 2)).to eq true
    end
    it 'phase 2' do
      cell = Cell.new(world, 0, 1)
      cell.spawn_at(1, 1)
      cell.spawn_at(2, 1)
      world.tick!
      world.tick!
      expect(world.cell_exists?(2, 1)).to eq true
      expect(world.cell_exists?(0, 1)).to eq true
      expect(world.cell_exists?(1, 1)).to eq true
    end
  end

  context 'can generate a block' do
    it 'do not change after 1 tick' do
      Cell.new(world, 1, 1)
      Cell.new(world, 2, 1)
      Cell.new(world, 2, 2)
      Cell.new(world, 1, 2)
      world.tick!
      expect(world.cell_exists?(1, 1)).to eq true
      expect(world.cell_exists?(2, 1)).to eq true
      expect(world.cell_exists?(2, 2)).to eq true
      expect(world.cell_exists?(1, 2)).to eq true
    end

    it 'do not change after 2 ticks' do
      Cell.new(world, 1, 1)
      Cell.new(world, 2, 1)
      Cell.new(world, 2, 2)
      Cell.new(world, 1, 2)
      world.tick!
      world.tick!
      expect(world.cell_exists?(1, 1)).to eq true
      expect(world.cell_exists?(2, 1)).to eq true
      expect(world.cell_exists?(2, 2)).to eq true
      expect(world.cell_exists?(1, 2)).to eq true
    end
  end

  context 'can generate spaceship' do
    it 'is the same after 4 ticks with a speed of c/4' do
      Cell.new(world, 1, 3)
      Cell.new(world, 2, 3)
      Cell.new(world, 3, 3)
      Cell.new(world, 3, 2)
      Cell.new(world, 2, 1)
      world.tick!
      world.tick!
      world.tick!
      world.tick!
      expect(world.cell_exists?(1 + 1, 3 + 1)).to eq true
      expect(world.cell_exists?(2 + 1, 3 + 1)).to eq true
      expect(world.cell_exists?(3 + 1, 3 + 1)).to eq true
      expect(world.cell_exists?(3 + 1, 2 + 1)).to eq true
      expect(world.cell_exists?(2 + 1, 1 + 1)).to eq true
    end
  end
end
