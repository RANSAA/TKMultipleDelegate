# TKMultipleDelegate

[![CI Status](https://img.shields.io/travis/sayaDev/TKMultipleDelegate.svg?style=flat)](https://travis-ci.org/sayaDev/TKMultipleDelegate)
[![Version](https://img.shields.io/cocoapods/v/TKMultipleDelegate.svg?style=flat)](https://cocoapods.org/pods/TKMultipleDelegate)
[![License](https://img.shields.io/cocoapods/l/TKMultipleDelegate.svg?style=flat)](https://cocoapods.org/pods/TKMultipleDelegate)
[![Platform](https://img.shields.io/cocoapods/p/TKMultipleDelegate.svg?style=flat)](https://cocoapods.org/pods/TKMultipleDelegate)

## Introduction

iOS 多delegate，多代理，多委托实现方案

## Installation


```ruby
pod 'TKMultipleDelegate'
```


## Tutorial

```
@property(nonatomic, strong) TKMultipleDelegate *delegates;
```

```
[self.delegates addDelegate:delegate1];
[self.delegates addDelegate:delegate2];
[self.delegates addDelegate:delegate3];
//add more delegate
```

```
[self.delegates performSelector:aSelector];
```


## Author

sayaDev, 1352892108@qq.com

## License

TKMultipleDelegate is available under the MIT license. See the LICENSE file for more info.
