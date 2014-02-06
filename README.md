# ConvertFont

A ClI tool to convert fonts.

## Installation

    $ gem install convert_font

## Usage

#### Basic

    convert_font convert -i /home/myproject/my_font_file.ttf -f eot,woff,svg

Convert the font at `/home/myproject/my_font_file.ttf` to the formats eot, woff, and svg. The converted fonts will be placed in your current working directory.

#### Advanced

    convert_font convert -i /home/myproject/my_font_file.ttf -f eot,woff,svg -d /home/Downloads/ -c false

Convert the font at `/home/myproject/my_font_file.ttf` to the formats eot, woff, and svg. The converted fonts will be placed in `/home/Downloads/`. The downloaded .tar.gz files will NOT be cleaned up.

The `convert` command tells `convert_font` to.... convert a font (redundant, I know).

The `-i` option is the input file, it must be an absolute path to your font file, ex. `-i /home/myproject/my_font_file.ttf`.

The `-f` option is a comma separated list of formats, ex. `-f eot,woff,svg`.

The `-d` option is the destination of the converted fonts, if ommited the current working directory is used, ex. `-d /home/Downloads/`.

The `-c` option is a flag to NOT clean up the downloaded .tar.gz files, they are deleted by default after they are processed, ex. '-c false'

## Changelog

- **Version 0.0.1:** Initial Release

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write specs, pull requests go much smoother if you have tests written for your new feature.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
