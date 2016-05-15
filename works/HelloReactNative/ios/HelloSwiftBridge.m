//
//  HelloSwiftBridge.m
//  HelloWorld
//
//  Created by Tatsuya Tobioka on 5/15/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(HelloSwift, NSObject)

RCT_EXTERN_METHOD(hello:(NSString *)message callback:(RCTResponseSenderBlock *)callback)

@end