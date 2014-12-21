# TiltFS

[![Build Status](https://travis-ci.org/sh19910711/ruby-tilt-fs.svg?branch=master)](https://travis-ci.org/sh19910711/ruby-tilt-fs)

The user space file system based on [Tilt](https://github.com/rtomayko/tilt).

## Installation

    $ gem install tilt-fs

## Usage

### 1. Mount the filesystem

```bash
$ cd {some_dir}
$ mkdir _template
$ mkdir mnt
$ echo 'Hello, <%= name %>' > _template/hello.txt
$ tiltfs mnt/ _template/
-> Mount "_template" into "mnt"
```

### 2. Access to the files

```bash
$ cd {some_dir}
$ cat mnt/hello.txt
Hello, <%= name %>
$
$ mv _template/hello.txt _template/hello.txt.erb
$ ruby -r yaml -e "puts({name: "world"}.to_yaml)" > .data.yaml
$ cat mnt/hello.txt
Hello, world
$
$ ruby -r yaml -e "puts({name: "NEW WORLD"}.to_yaml)" > .data.yaml
$ cat mnt/hello.txt
Hello, NEW WORLD
```

### 3. Unmount the filesystem

```bash
$ cd {some_dir}
$ fusermount -u mnt/
```

## Contributing

1. Fork it ( https://github.com/sh19910711/ruby-tilt-fs/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
