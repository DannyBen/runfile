<div align='center'>

# Runfile - command line for your projects

[![Gem Version](https://badge.fury.io/rb/runfile.svg)](https://badge.fury.io/rb/runfile)
[![Build Status](https://github.com/DannyBen/runfile/workflows/Test/badge.svg)](https://github.com/DannyBen/runfile/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/81cf02ccfcc8531cb09f/maintainability)](https://codeclimate.com/github/DannyBen/runfile/maintainability)

---

A beautiful command line application framework.  
Rake-inspired, Docopt inside.

---

</div>

**Runfile** lets you create command line applications in a way similar 
to [Rake](https://github.com/ruby/rake), but with the full power of 
[Docopt](http://docopt.org/) command line options.

You create a `Runfile`, and execute commands with 
`run command arguments -and --flags`.

![Runfile Demo](demo.svg "Runfile Demo")

## Quick Start

```shell
$ run new        # create a new Runfile
$ run --help     # show the usage patterns
$ vi Runfile     # edit the Runfile
```


## Example

The most minimal `Runfile` looks like this:

```ruby
usage  "greet <name>"
action :greet do |args|
  puts "Hello #{args['<name>']}" 
end
```

You can then run it by executing this command:

```shell
$ run greet Luke
Hello Luke
```

Executing `run` without parameters, will show the usage patterns:

```shell
$ run
Usage:
  run greet <name>
  run (-h|--help|--version)
```

Executing `run --help` will show the full help document (docopt)

```shell
$ run --help
Runfile 0.0.0

Usage:
  run greet <name>
  run (-h|--help|--version)

Options:
  -h --help
      Show this screen

  --version
      Show version
```

## Documentation

- [User Guide](https://runfile.dannyb.co/)
- [Learn by Example](https://github.com/DannyBen/runfile/tree/master/examples#readme)

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue](https://github.com/DannyBen/runfile/issues).

