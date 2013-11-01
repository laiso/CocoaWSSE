CocoaWSSE
===================

[![Build Status](https://travis-ci.org/laiso/CocoaWSSE.png?branch=master)](https://travis-ci.org/laiso/CocoaWSSE)

A WSSE authentication header for Cocoa.

```objc

NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://..."]];
[req setValue:[CocoaWSSE headerWithUsername:@"sample" password:@"passwd"] forHTTPHeaderField:@"X-WSSE"];

[NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *res, NSData *data, NSError *err) {
    ...
}];

```

```
(lldb) po [req allHTTPHeaderFields]
...
    "X-WSSE" = "UsernameToken Username=\"sample\", PasswordDigest=\"4KgZgUd7Nl2XZUHKOuS/EKPUL04=\", Nonce=\"QjIwOUZEQzQ4RjQ2NUEyRkRCMTgwQkM5RjlFNzM2N0UwNkUwNDlENw==\", Created=\"2013-09-19T19:15:04+0900\"";
```

Install
============

```ruby
pod 'CocoaWSSE', :git => 'https://github.com/laiso/CocoaWSSE.git'
```
