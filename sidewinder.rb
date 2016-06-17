class Sidewinder
  def self.on(grid, full_dir: :east, run_dir: :south)
    grid.each_row do |row|
      run = []

      row.each do |cell|
        run << cell

        at_run_boundary  = cell.send(run_dir).nil?
        at_full_boundary = cell.send(full_dir).nil?
        should_close_out = at_run_boundary \
          || ( !at_full_boundary && rand(2).zero? )

        if should_close_out
          member = run.sample
          break_to = member.send(full_dir)
          member.link(break_to) if break_to
          run.clear
        else
          cell.link(cell.send(run_dir))
        end
      end
    end

    grid
  end
end
