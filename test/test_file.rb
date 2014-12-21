class TestFile < Test::Unit::TestCase

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

  test "file#content" do
    FileUtils.mkdir_p "/path/to"
    FileUtils.touch "/path/to/hello"
    File.write "/path/to/hello", "hello, world"
    file = Tilt::Fs::FileSystem::File.new("/path/to/hello")
    assert_equal "hello, world", file.content
  end

  test "file#is_file?()" do
    FileUtils.mkdir_p "/path/to"
    FileUtils.touch "/path/to/hello"
    File.write "/path/to/hello", "hello, world"
    file = Tilt::Fs::FileSystem::File.new("/path/to/hello")
    assert_equal true, file.is_file?
  end

  test "file#is_dir?()" do
    FileUtils.mkdir_p "/path/to"
    FileUtils.touch "/path/to/hello"
    File.write "/path/to/hello", "hello, world"
    file = Tilt::Fs::FileSystem::File.new("/path/to/hello")
    assert_equal false, file.is_dir?
  end

  test "file#name" do
    FileUtils.mkdir_p "/path/to"
    FileUtils.touch "/path/to/hello.txt.erb"
    File.write "/path/to/hello.txt.erb", "hello"
    file = Tilt::Fs::FileSystem::File.new("/path/to/hello.txt.erb")
    assert_equal "hello.txt", file.name
  end

end