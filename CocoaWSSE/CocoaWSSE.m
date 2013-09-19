//
//  CocoaWSSE.m
//  CocoaWSSE
//
//  Copyright (c) 2013 laiso. All rights reserved.
//

#import "CocoaWSSE.h"

#import <CocoaSecurity/CocoaSecurity.h>

@implementation CocoaWSSE

+ (NSString *)headerWithUsername:(NSString *)username password:(NSString *)password
{
  NSString* formattedDate = [self createFormattedDate];
  NSString *nonce = [[CocoaSecurity sha1:[NSString stringWithFormat:@"%@%d", formattedDate, arc4random()]] hex];
	NSString *passwordDigest = [[CocoaSecurity sha1:[NSString stringWithFormat:@"%@%@%@", nonce, formattedDate, password]] base64];
	NSString *base64 = [[CocoaSecurityEncoder new] base64:[nonce dataUsingEncoding:NSASCIIStringEncoding]];
	NSString *credentials = [NSString stringWithFormat:
                           @"UsernameToken Username=\"%@\", "
                           @"PasswordDigest=\"%@\", "
                           @"Nonce=\"%@\", "
                           @"Created=\"%@\"", username, passwordDigest, base64, formattedDate];
	return credentials;
}

#pragma mark - Private

+ (NSString *)createFormattedDate
{
  // https://github.com/kishikawakatsumi/hatena-touch/blob/master/Classes/HatenaAtomPub.m#L37
  NSDate* now = [NSDate date];
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"US"]];
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
  return [dateFormatter stringFromDate:now];
}

@end
