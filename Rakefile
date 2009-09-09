require 'rake/clean'
require './lib/ant'
CLEAN << "build" << "greeter.jar"

directory "build"

namespace :plain do
  desc "Compile the code"
  task "compile" => "build" do |t|
    files = FileList["src/**/*.java"]
    cpath =  FileList["lib/*.jar"].join(':')
    sh "javac -d #{t.prerequisites.first} -classpath #{cpath} #{files}"
  end

  desc "Create a jar file of the compiled code"
  task "jar" => "compile" do
    sh "jar cf greeter.jar -C build ."
  end
end

namespace :ant do
  desc "Compile the code"
  task "compile" => "build" do |t|
    ant.javac :srcdir => "src", :destdir => "build" do
      ant.classpath do
        FileList["lib/*.jar"].each do |jar|
          ant.pathelement :path => jar
        end
      end
    end
  end

  desc "Create a jar file of the compiled code"
  task "jar" => "ant:compile" do
    ant.jar :destfile => "greeter.jar", :basedir => "build"
  end
end

require 'cucumber/rake/task'
$CLASSPATH << "build"

desc "Run Cucumber on the project"
Cucumber::Rake::Task.new(:cucumber => "plain:compile")

task :default => :cucumber
