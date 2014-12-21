module Tilt::Fs::FileSystem

  require "tilt"
  require "yaml"

  require "tilt/fs/file_system/core"
  require "tilt/fs/file_system/dir"
  require "tilt/fs/file_system/constants"
  require "tilt/fs/file_system/file"

  require "logger"
  FS_LOGGER = ::Logger.new(STDOUT)
  FS_LOGGER.level = ::Logger::Severity::INFO
  FS_LOGGER.level = ::Logger::Severity::DEBUG if ENV["TILTFS_DEBUG"] === "true"

end