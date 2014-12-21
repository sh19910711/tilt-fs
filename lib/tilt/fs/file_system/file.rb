module Tilt::Fs::FileSystem

  class File

    attr_reader :logger
    attr_reader :real_path
    attr_reader :data_path
    attr_reader :content

    def initialize(new_real_path, new_data_path = nil)
      @real_path = new_real_path
      @logger = FS_LOGGER
      @data_path = new_data_path
      @content = render_content

      logger.debug "file#new(): created, real_path = #{real_path}, data_path = #{data_path}"
    end

    def render_content
      if ::Tilt.templates_for(real_path).empty?
        ::File.read real_path
      else
        template_data = load_template_data
        template = ::Tilt.new(real_path, nil)
        begin
          template.render self, template_data
        rescue => e
          logger.warn "file#render_content(): #{e}"
          raise "error on file#render_content()"
        end
      end
    end

    def load_template_data
      if data_path.nil? || (not ::FileTest.file? data_path)
        logger.debug "file#load_template_data(): no data"
        {}
      else
        logger.debug "file#load_template_data(): data_path = #{data_path}"
        ::YAML.load_file data_path
      end
    end

    # e.g. "foo.txt.erb" => "foo.txt"
    def name
      res = ::Pathname.new(real_path).basename.to_s
      if /\.erb$/ === res
        res.gsub /\.erb$/, ""
      else
        res
      end
    end

    def is_dir?
      false
    end

    def is_file?
      true
    end

    def stat
      {
          :uid => ::Process.uid,
          :gid => ::Process.gid,
          :atime => ::Time.now,
          :mtime => ::Time.now,
          :size => content.length,
      }
    end

    def attr
      ::RFuse::Stat.file FS_DEFAULT_FILE_MODE, stat
    end

  end

end