### Overview
[![Travis CI](https://travis-ci.org/rambler-digital-solutions/rambler-it-ios.svg?branch=develop)](https://travis-ci.org/rambler-digital-solutions/rambler-it-ios)

**Rambler&IT** is an open source application, which highlights the basic approaches to mobile application architecture used in *Rambler&Co*. You can download it from the [AppStore](https://itunes.apple.com/us/app/rambler-it/id1145829115).

The design map:
![Design map](http://i.imgur.com/MhQqy87.png)

### Key Features

- The application is divided into three layers: `Presentation`, `BusinessLogic` and `Core`.
- The `Presentation` layer is built using [VIPER architecture](https://github.com/rambler-digital-solutions/The-Book-of-VIPER).
- The `BusinessLogic` layer is built using SOA.
- The `Core` layer is built using compound operations concept.
- We extensively use [Typhoon framework](https://github.com/appsquickly/Typhoon) for dependency injection.

### Usage

The application uses staging API which is not available outside our private network at the moment. We'll make it public really soon.

### Installation

Install `Carthage` before launching the project.
You can use [Homebrew](http://brew.sh/) and install the Carthage tool on your system simply by running `brew update` and `brew install carthage`. (note: if you previously installed the binary version of Carthage, you should delete /Library/Frameworks/CarthageKit.framework).
More info about Carthage installation you can find [here](https://github.com/Carthage/Carthage).

Run `pod install` before launching the project. All of inner dependencies are public.

### License

MIT

### Authors

Egor Tolstoy, Artem Karpushin, Konstantin Zinovyev and the rest of Rambler.iOS Team.
