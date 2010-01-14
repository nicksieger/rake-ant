require 'java'

# Hacked for now.  Must replace with auto-discovery with simple explicit set
# option.

# ant-launcher.jar is required because we use Project.init()
homes = [ENV['ANT_HOME'] && File.join(ENV['ANT_HOME'], 'lib'),
        '/usr/share/ant/lib']
file = homes.detect {|h| h && File.exist?(h) }
$CLASSPATH << File.join(file, 'ant.jar') << File.join(file, 'ant-launcher.jar')

require 'ant/ant'
require 'ant/rake' if defined?(::Rake)
