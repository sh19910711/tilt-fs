# TiltFS

The user space file system based on [Tilt](https://github.com/rtomayko/tilt).

## Installation

    $ gem install tilt-fs

## Usage

### 1. Run the filesystem

    $ cd {some_dir}
    $ mkdir _template
    $ mkdir mnt
    $ echo 'Hello, <%= name %>' > _template/hello.txt.erb
    $ tiltfs mnt/ _template/
    -> Mount "_template" into "mnt"

### 2. Access to the files

    $ cd {some_dir}
    $ ruby -r yaml -e "puts({name: "world"}.to_yaml)" > .data.yaml
    $ cat mnt/hello.txt
    Hello, world
    $ ruby -r yaml -e "puts({name: "NEW WORLD"}.to_yaml)" > .data.yaml
    $ cat mnt/hello.txt
    Hello, NEW WORLD

## Contributing

1. Fork it ( https://github.com/sh19910711/ruby-tilt-fs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
