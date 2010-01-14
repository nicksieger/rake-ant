require 'java'
require 'ant/element'

java_import org.apache.tools.ant.ComponentHelper
java_import org.apache.tools.ant.DefaultLogger
java_import org.apache.tools.ant.Project
java_import org.apache.tools.ant.Target

# A couple of notes on where this is heading:
# 1. project may be acquired if a Rakefile is being called from ant.  We need to
#    add an option to pass in the project for this state
# 2. target that we add is certainly not how things will work by default. In
#    rake scenario we will construct an ant task for each rake task or an ant
#    for each ant task, but it will need to be connected with a rake task.
# As you can tell from the above statements the mixed mode aspect is still
# being figured out a little.
class Ant
  attr_reader :project

  def initialize(options={}, &block)
    @options = options
    @project = create_project options
    initialize_elements
    @default = Target.new # Add generic target until this gets connected
    block.arity == 1 ? block[self] : instance_eval(&block) if block_given?
    @default.execute
  end

  def create_project(options)
    Project.new.tap do |p| 
      p.init
      p.add_build_listener(DefaultLogger.new.tap do |log|
        log.output_print_stream = java.lang.System.out
        log.error_print_stream = java.lang.System.err
        log.emacs_mode = true
        log.message_output_level = options[:output_level] || 1
      end)
    end
  end

  # For each default data type and task definitions we generate top-level
  # methods for this instance of ant (e.g. ant project).  This eliminates
  # the need for relying on method_missing for try and bootstrap tasks/types.
  def initialize_elements
    @elements = {}
    @helper = ComponentHelper.get_component_helper @project
    generate_children @project.data_type_definitions
    generate_children @project.task_definitions
  end

  # All elements (including nested elements) are registered so we can
  # access them easily.
  def acquire_element(name, clazz)
    element = @elements[name]

    unless element
      # Not registered in ant's type registry for this project (nested el?)
      unless @helper.get_definition(name)
        puts "Adding #{name} -> #{clazz.inspect}" if debug?
        @helper.add_data_type_definition(name, clazz)
      end

      @elements[name] = :give_it_something_to_prevent_endless_recursive_defs
      element = @elements[name] = Element.new(self, name, clazz)
    end

    element
  end

  def generate_children(collection)
    collection.each do |name, clazz|
      element = acquire_element(name, clazz)
      self.class.send(:define_method, name) do |*a, &b| 
        element.call(@default, *a, &b)
      end
    end
  end

  def debug?
    @options[:output_level] && @options[:output_level] > 3
  end
end
