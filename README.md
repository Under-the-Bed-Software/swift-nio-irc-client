# SwiftNIO IRC Client

![Swift4](https://img.shields.io/badge/swift-4-blue.svg)
![Swift5](https://img.shields.io/badge/swift-5-blue.svg)
![iOS](https://img.shields.io/badge/os-iOS-green.svg?style=flat)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![tuxOS](https://img.shields.io/badge/os-tuxOS-green.svg?style=flat)
<a href="https://travis-ci.org/NozeIO/swift-nio-irc-client"><img src="https://travis-ci.org/NozeIO/swift-nio-irc-client.svg?branch=develop" /></a>

SwiftNIO-IRC is a Internet Relay Chat 
protocol implemention for
[SwiftNIO](https://github.com/apple/swift-nio)
and a simple 
[IRC client](Sources/IRC).

This module contains a simple IRC client library. Also provided:

- [BrickBot](https://github.com/Under-the-Bed-Software/BrickBot) - A simple IRC bot using swift-nio-irc-client

This is also the primary IRC client driver for a new and still work-in-progress iOS IRC client.
Stay tuned for more updates which will become available in the near future.

NIOIRC is a SwiftNIO port of the
[Noze.io miniirc](https://github.com/NozeIO/Noze.io/tree/master/Samples/miniirc)
example from 2016.

## Features

Currently, I'm not sure the breadth of the features of this IRC client implementation.
As far as I am aware there are not very many [IRCv3](https://ircv3.net) features
supported, but that's something I'm currently working on making happen.

## Importing the module using Swift Package Manager

An example `Package.swift `importing the necessary modules:

```swift
// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "IRCTests",
    dependencies: [
        .package(url: "https://github.com/Under-the-Bed-Software/swift-nio-irc-client.git",
                 from: "0.8.2")
    ],
    targets: [
        .target(name: "MyIRCClient",
                dependencies: [ "IRC" ])
    ]
)
```


### Who

This software is a fork of [NozeIO's version](https://github.com/NozeIO/swift-nio-irc-client) implementation under the same name. This software was licensed under the Apache 2.0 license, and continues to be. 

The original author of swift-nio-irc-client was made by [ZeeZide](http://zeezide.de). Please check them out!
