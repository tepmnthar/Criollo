//
//  CRFCGIServerConfiguration.m
//  Criollo
//
//  Created by Cătălin Stan on 10/30/15.
//  Copyright © 2015 Cătălin Stan. All rights reserved.
//

#import "CRFCGIServerConfiguration.h"

// Defaults
static NSTimeInterval const CRFCGIConnectionDefaultReadRecordTimeout = 5.;
static size_t const CRFCGIConnectionDefaultSocketWriteBuffer = 32 * 1024;

// Keys
static NSString * const CRFCGIConnectionReadRecordTimeoutKey = @"CRFCGIConnectionReadRecordTimeout";
static NSString * const CRFCGIConnectionSocketWriteBufferKey = @"CRFCGIConnectionSocketWriteBuffer";

@implementation CRFCGIServerConfiguration

- (void)readConfiguration {
    [super readConfiguration];

    NSBundle* mainBundle = [NSBundle mainBundle];
    if ([mainBundle objectForInfoDictionaryKey:CRFCGIConnectionReadRecordTimeoutKey]) {
        _CRFCGIConnectionReadRecordTimeout = [[mainBundle objectForInfoDictionaryKey:CRFCGIConnectionReadRecordTimeoutKey] doubleValue];
    } else {
        _CRFCGIConnectionReadRecordTimeout = CRFCGIConnectionDefaultReadRecordTimeout;
    }

    if ([mainBundle objectForInfoDictionaryKey:CRFCGIConnectionSocketWriteBufferKey] ) {
        _CRFCGIConnectionSocketWriteBuffer = [[mainBundle objectForInfoDictionaryKey:CRFCGIConnectionSocketWriteBufferKey] unsignedLongLongValue];
    } else {
        _CRFCGIConnectionSocketWriteBuffer = CRFCGIConnectionDefaultSocketWriteBuffer;
    }

}


@end
