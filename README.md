dart mv
==========

[![Build Status](https://drone.io/github.com/julien/dart_mv/status.png)](https://drone.io/github.com/julien/dart_mv/latest)

[Dart](http://www.dartlang.org) Model/View implementation.

A minimalist library that implements a Model and a View class.

A basic example is provided in the "web" directory.

Although the build status is "failing" since about two months,
the tests pass in Dartium.

**TODO**
- Fix tests.
  Passes in Chromium on Windows, OS X, Ubuntu.
  Fails with DumpRenderTree on OSX/nix but passes on Windows.

- Add more tests (View and Router currently aren't tested at all).

- Generate documentation.

- Ideas:
  The code is so "small" that each part could eventually
  be used independently ... It might be wiser to isolate
  each "part" into it's own library.

*[Available](http://pub.dartlang.org/packages/dart_mv) at the Dart [pub](http://pub.dartlang.org)*

**author**

*Julien Castelain* <jcastelain@gmail.com>

