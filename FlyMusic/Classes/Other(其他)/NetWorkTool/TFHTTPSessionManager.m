//
//  TFHTTPSessionManager.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/29.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFHTTPSessionManager.h"

@implementation TFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        //        self.securityPolicy.validatesDomainName = NO;
        //        self.responseSerializer = nil;
        //        self.requestSerializer = nil;
    }
    return self;
}
@end
