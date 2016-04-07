Runfile Feature Tests
=====================

Runfile tests are built with Cucumber, and with the 
[Clicumber step definitions](https://github.com/DannyBen/clicumber)

To run all features:

	$ cd /repository/root/folder
	$ run feature

> **Note:** 
> If you have a `~/runfile` or `/etc/runfile` folder in your system, you
> will have to rename them before running the tests. This is needed so that 
> all the tests that expect to "not find any runfile" will fail if these 
> directories exist.
