require 'ant'
ant :name => "rake-ant", :default => "help" do
  property :name => "src.dir", :value => "src/main/java"
  property :name => "build.dir", :value => "target"
  property :name => "classes.dir", :value => "${build.dir}/classes"
  property :name => "jar.file", :value => "${build.dir}/rake-ant.jar"

  target "clean", :description => "Clean the output" do
    delete :dir => "${build.dir}"
  end

  target :name => :classes_dir do
    mkdir :dir => "${classes.dir}"
  end

  target :name => :compile, :depends => :classes_dir, :description => "Compile the code" do
    javac :srcdir => "${src.dir}", :destdir => "${classes.dir}" do
      classpath do
        Dir["lib/*.jar"].each do |jar|
          pathelement :path => jar
        end
      end
    end
  end

  target :name => :jar, :depends => :compile, :description => "Create the jar file" do
    jar :destfile => "${jar.file}", :basedir => "${classes.dir}"
  end

  target :name => "help" do
    echo :message => <<-MSG
Welcome to the #{project.name} project.

This is an example of a Ruby-based ant build. Look in `#{__FILE__}' to
see the project's contents.

#{project_help}
MSG
  end
end
