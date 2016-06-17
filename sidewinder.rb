require 'virtus'

class Sidewinder
  include Virtus.model

  attribute :grid
  attribute :run_dir  # the direction in which runs extend; will be a continuous corridor
  attribute :full_dir # the other continuous corridor, for which I lack a better name...

  def self.on(grid, full_dir: :north, run_dir: :east)
    instance = new(grid: grid, full_dir: full_dir, run_dir: run_dir)
    instance.carve
    grid
  end

  def carve
    grid.each_row do |row|
      run = []

      row.each do |cell|
        run << cell

        if should_close_out?(run)
          close_out run
        else
          continue run
        end
      end
    end
  end

  def should_close_out?(run)
    cell = run.last
    return true  if at_run_boundary?(cell)
    return false if at_full_boundary?(cell)
    rand(2).zero?
  end

  def at_run_boundary?(cell)
    cell.send(run_dir).nil?
  end

  def at_full_boundary?(cell)
    cell.send(full_dir).nil?
  end

  def close_out(run)
    member = run.sample
    break_to = member.send(full_dir)
    member.link(break_to) if break_to
    run.clear
  end

  def continue(run)
    cell = run.last
    next_cell = cell.send(run_dir)
    cell.link next_cell
  end
end
