require "bundler/setup"
Bundler.require :development
require "tilt/fs"

base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
test_dir = File.join(base_dir, "test")

exit Test::Unit::AutoRunner.run(true, test_dir)