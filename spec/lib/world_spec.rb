require 'spec_helper'
require 'world'

describe 'World' do
  let(:world) { World.new(20, 20) }
  it 'will destroy cell outer of limits after tick!' do
    cell = Cell.new(world, -1, -1)
    world.tick!
    expect(cell).to be_dead
  end

  it 'refresh died cells who can changed state' do
    Cell.new(world)
    world.refresh_died_cells
    expect(world.died_cells.count).to eq 8
  end

  it 'detects if a cell exists at coordinates' do
    Cell.new(world)
    expect(world.cell_exists?(0, 0)).to eq true
  end

  it 'can generate cells randomly' do
    world.generate_cells(50)
    expect(world.cells.count).to eq 200
  end
end
