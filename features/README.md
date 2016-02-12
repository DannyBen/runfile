Runfile Feature Tests
=====================

To run all features:

	$ cd /repository/root/folder
	$ run test

> **Note:** 
> If you have a `~/runfile` or `/etc/runfile` folder in your system, you
> will have to rename them before running the tests. This is needed so that 
> all the tests that expect to "not find any runfile" will fail if these 
> directories exist.
