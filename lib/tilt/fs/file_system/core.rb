module Tilt::Fs::FileSystem

  class Core

    attr_reader :logger
    attr_reader :root_dir
    attr_reader :mount_point
    attr_reader :src_path
    attr_reader :template_data_file

    def initialize(new_mount_point, new_src_path = "./")
      @logger = FS_LOGGER
      @src_path = new_src_path
      @template_data_file = ::File.join(::Dir.pwd, FS_DEFAULT_DATA_FILE)
      @root_dir = Dir.new(src_path, template_data_file)
      @mount_point = new_mount_point

      logger.debug "core#new(): created"
      logger.info "Mounted into #{mount_point} from #{src_path}"
      logger.info "Template data path = #{template_data_file}"
    end

    def init(ctx, rfuse_info)
      logger.info "Tilt::Fs started."
    end

    def readdir(ctx, path, filter, offset, ffi)
      logger.info "READ_DIR: #{::File.join mount_point, path}"
      logger.debug "Core#readdir(): ctx = #{ctx}, path = #{path}"
      dir = root_dir.find(path)

      raise ::Errno::ENOTDIR.new(path) unless dir.is_dir?

      token = ::Pathname.new(path).basename.to_s
      dir.search(token).each do |entry|
        filter.push entry.name, entry.attr, 0
      end
    end

    def open(ctx, path, ffi)
      logger.debug "Core#open(): path = #{path}"
    end

    def read(ctx, path, size, offset, ffi)
      logger.info "READ_FILE: #{::File.join mount_point, path}"
      logger.debug "Core#read(): path = #{path}, size = #{size}"
      root_dir.find(path).content
    end

    def getattr(ctx, path)
      logger.debug "Core#getattr(): path = #{path}"
      root_dir.find(path).attr
    end

  end

end