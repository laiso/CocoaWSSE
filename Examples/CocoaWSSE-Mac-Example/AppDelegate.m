//
//  AppDelegate.m
//  CocoaWSSE-Mac-Example
//
//    9/19/13.
//
//

#import "AppDelegate.h"

#import "CocoaWSSE.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8000/"]];
  [req setValue:[CocoaWSSE headerWithUsername:@"sample" password:@"passwd"] forHTTPHeaderField:@"X-WSSE"];
 [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *res, NSData *data, NSError *err) {
    NSString* status = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", status);
 }];
}

@end
