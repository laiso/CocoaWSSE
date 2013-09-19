//
//  AppDelegate.m
//  CocoaWSSE-iOS-Example
//
//    9/19/13.
//
//

#import "AppDelegate.h"

#import "CocoaWSSE.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window makeKeyAndVisible];
  
  NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8000/"] cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:3];
  [req setValue:[CocoaWSSE headerWithUsername:@"sample" password:@"passwd"] forHTTPHeaderField:@"X-WSSE"];
  
  [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *res, NSData *data, NSError *err) {
    if(err){
      NSLog(@"%@", err);
      printf("======================================================\n");
      printf("Please run server script. `python Scripts/server.py`\n");
      printf("======================================================\n");
    }
    
    NSString* status = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", status);
  }];
  
  return YES;
}

@end
