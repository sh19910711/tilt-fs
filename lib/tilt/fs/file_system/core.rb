require "logger"

module Tilt::Fs

  class FileSystem::Core

    attr_reader :logger
    attr_reader :root_dir

    DEFAULT_DIR_MODE = 0755
    DEFAULT_FILE_MODE = 0744

    def initialize(src_path = "./")
      @logger = ::Logger.new(STDOUT)
      logger.level = ::Logger::Severity::DEBUG # TODO: change
      @root_dir = FileSystem::Dir.new(src_path)
    end

    def init(ctx, rfuse_info)
      logger.info "Tilt::Fs started."
    end

    def dir_stat
      stat = {
          :uid => 0,
          :gid => 0,
          :atime => ::Time.now,
          :mtime => ::Time.now,
          :size => 0,
      }
      ::RFuse::Stat.directory 0755, stat
    end

    def file_stat
      stat = {
          :uid => 0,
          :gid => 0,
          :atime => ::Time.now,
          :mtime => ::Time.now,
          :size => 0,
      }
      ::RFuse::Stat.file 0744, stat
    end

    def readdir(ctx, path, filter, offset, ffi)
      logger.debug "Core#readdir(): path = #{path}"
    end

    def open(ctx, path, ffi)
      logger.debug "Core#open(): path = #{path}"
    end

    def read(ctx, path, size, offset, ffi)
      logger.debug "Core#read(): path = #{path}, size = #{size}"
    end

    def getattr(ctx, path)
      logger.debug "Core#getattr(): path = #{path}"
    end

  end

end