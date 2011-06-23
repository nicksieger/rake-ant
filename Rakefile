require "rubygems"
require "bundler/setup"

$LOAD_PATH.unshift "./lib"

src_dir = 'src/main/java'
build_dir = 'target'
classes_dir = 'target/classes'
jar_file = "#{build_dir}/rake-ant.jar"
directory classes_dir

# Plain, free-form command-line
namespace :plain do
  desc "Compile the code"
  task :compile => classes_dir do
    files = FileList["#{src_dir}/**/*.java"]
    cpath = FileList["lib/*.jar"].join(':')
    sh "javac -d #{classes_dir} -classpath #{cpath} #{files}"
  end

  desc "Create a jar file of the compiled code"
  task :jar => :compile do
    sh "jar cf #{jar_file} -C #{classes_dir} ."
  end
end

# Ant-based tasks
require 'ant'
namespace :ant do
  desc "Compile the code using Ant"
  task :compile => classes_dir do
    puts "Compiling java from #{src_dir} to #{classes_dir}"
    ant.javac :srcdir => src_dir, :destdir => classes_dir do
      classpath do
        FileList["lib/*.jar"].each do |jar|
          pathelement :path => jar
        end
      end
    end
  end

  desc "Create a jar file of the compiled code using Ant"
  task :jar => "ant:compile" do
    puts "Creating #{jar_file}"
    ant.jar :destfile => jar_file, :basedir => classes_dir
  end
end

# Set classpath for RSpec and Cucumber
$CLASSPATH << classes_dir
ENV['CLASSPATH'] = $CLASSPATH.to_a.join(File::PATH_SEPARATOR)

# RSpec
require 'rspec/core/rake_task'
spec_dir = 'src/spec/ruby'
desc "Run RSpec on the project"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "#{spec_dir}/**/*_spec.rb"
  t.rspec_opts = '--format documentation'
end
task :spec => "ant:compile"

task :default => :spec

# Cucumber
require 'cucumber/rake/task'

desc "Run Cucumber on the project"
Cucumber::Rake::Task.new(:features => "ant:compile")

task :default => :features

# Clean
require 'rake/clean'
CLEAN << build_dir
