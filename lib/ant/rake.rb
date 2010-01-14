def ant_task(*args, &block)
  task(*args) do
    Ant.new(&block)
  end
end
