ANT_HOME = '/usr/share/ant'
FileList["#{ANT_HOME}/lib/*.jar"].each {|jar| $CLASSPATH << jar}
require 'antwrap'
def ant
  @ant ||= Antwrap::AntProject.new(:ant_home => ANT_HOME)
end
