module Tilt::Fs::FileSystem

  class Dir

    attr_reader :name
    attr_reader :logger
    attr_reader :real_path
    attr_reader :data_path
    attr_reader :flag_no_data

    def initialize(new_real_path, new_data_path)
      @logger = FS_LOGGER
      @real_path = new_real_path
      @name = ::Pathname.new(real_path).basename.to_s
      @data_path = new_data_path
      logger.debug "dir#new(): created, real_path = #{real_path}"
    end

    def is_dir?
      true
    end

    def is_file?
      false
    end

    def stat
      {
          :uid => ::Process.uid,
          :gid => ::Process.gid,
          :atime => ::Time.now,
          :mtime => ::Time.now,
          :size => 0,
      }
    end

    def attr
      ::RFuse::Stat.directory FS_DEFAULT_DIR_MODE, stat
    end

    def create_file_or_dir(path)
      logger.debug "dir#create_file_or_dir(): path = #{path}"
      if ::FileTest.directory?(path)
        Dir.new path, data_path
      else
        File.new path, data_path
      end
    end

    def glob_and_create(glob_path)
      ::Dir.glob(glob_path).map do |found_path|
        create_file_or_dir found_path
      end
    end

    def search(token)
      logger.debug "dir#search(): token = #{token}"
      glob_path = ::File.join(real_path, "#{token}*")
      logger.debug "dir#search(): glob_path = #{glob_path}"
      glob_and_create glob_path
    end

    def find(path)
      logger.debug "dir#find(): path = #{path}"
      lookup_path = ::File.join(real_path, path)
      if ::FileTest.file?(lookup_path)
        create_file_or_dir lookup_path
      elsif ::FileTest.directory?(lookup_path)
        create_file_or_dir lookup_path
      else
        logger.debug "dir#find(): find template for #{path}"
        templates = ::Dir.glob(::File.join real_path, "#{path}*")
        if templates.length === 1
          logger.debug "dir#find(): found in #{templates.first}"
          create_file_or_dir templates.first
        else
          raise ::Errno::ENOENT.new(path)
        end
      end
    end

  end

end