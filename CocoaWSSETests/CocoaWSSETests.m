//
//  CocoaWSSETests.m
//  CocoaWSSETests
//
//    9/19/13.
//  Copyright (c) 2013 laiso. All rights reserved.

#import <SenTestingKit/SenTestingKit.h>

#import "CocoaWSSE.h"

@interface CocoaWSSETests : SenTestCase
@end

@implementation CocoaWSSETests

- (void)testGenerateHeader
{
  NSString *header = [CocoaWSSE headerWithUsername:@"sample" password:@"passwd"];
  STAssertTrue([header hasPrefix:@"UsernameToken Username=\"sample\", PasswordDigest="], @"");
}

// SKIP(@"This test is doesn't work in Travis-CI");
/*
- (void)testRequestStubServer
{
  NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8000/"]];
  [req setValue:[CocoaWSSE headerWithUsername:@"sample" password:@"passwd"] forHTTPHeaderField:@"X-WSSE"];
  NSHTTPURLResponse* res;
  NSError* err;
  NSData* body = [NSURLConnection sendSynchronousRequest:req returningResponse:&res error:&err];
  
  STAssertNil(err, @"");
  STAssertEquals([res statusCode], 200, @"");
  NSString* status = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
  STAssertEqualObjects(status, @"OK\n", @"");
}
*/

@end
