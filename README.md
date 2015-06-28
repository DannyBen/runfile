Runfile - If Rake and Docopt had a baby
=======================================

[![Gem Version](https://badge.fury.io/rb/runfile.svg)](http://badge.fury.io/rb/runfile)
[![Build Status](https://travis-ci.org/DannyBen/runfile.svg?branch=master)](https://travis-ci.org/DannyBen/runfile)
[![Code Climate](https://codeclimate.com/github/DannyBen/runfile/badges/gpa.svg)](https://codeclimate.com/github/DannyBen/runfile)
[![Gem](https://img.shields.io/gem/dt/runfile.svg)](https://rubygems.org/gems/runfile)

A beautiful command line application framework.  
Rake-inspired, Docopt inside.


## Wait, What?

**Runfile** lets you create command line applications in a way similar 
to [Rake](https://github.com/ruby/rake), but with the full power of 
[Docopt](http://docopt.org/) command line options.

You create a `Runfile`, and execute commands with 
`run command arguments -and --flags`.

[Learn More in the Wiki](https://github.com/DannyBen/runfile/wiki)


## Install

	$ gem install runfile


## Quick Start

	$ run make
	$ run --help
	$ vi Runfile


## Example

The most minimal `Runfile` looks like this:

```ruby
usage  "greet <name>"
action :greet do |args|
	puts "Hello #{args['<name>']}" 
end
```

You can then run it by executing this command:

```
$ run greet Luke
Hello Luke
```

Executing `run` without parameters, will show the usage patterns:

```
$ run
Usage:
  run greet <name>
  run (-h | --help | --version)
```

Executing `run --help` will show the full help document (docopt)

```
$ run --help
Runfile 0.0.0

Usage:
  run greet <name>
  run (-h | --help | --version)

Options:
  -h --help
      Show this screen

  --version
      Show version
```

## Documentation 

- [Learn by Example](https://github.com/DannyBen/runfile/tree/master/examples)
- [Runfile Command Reference](https://github.com/DannyBen/runfile/wiki/Runfile-Command-Reference)
- [Wiki](https://github.com/DannyBen/runfile/wiki)
- [Rubydoc](http://www.rubydoc.info/gems/runfile)
