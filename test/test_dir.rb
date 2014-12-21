class TestDir < Test::Unit::TestCase

  setup do
    FakeFS.activate!
  end

  teardown do
    FakeFS.deactivate!
    FakeFS::FileSystem.clear
  end

  setup do
    Tilt::Fs::FileSystem::FS_LOGGER.level = Logger::Severity::UNKNOWN
  end

  test "dir#search()" do
    FileUtils.mkdir_p "/path/to"
    FileUtils.touch "/path/to/hello"
    dir = Tilt::Fs::FileSystem::Dir.new("/path/to", nil)
    assert_equal 1, dir.search("/hello").length
  end

end