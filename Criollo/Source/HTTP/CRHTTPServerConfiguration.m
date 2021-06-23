//
//  CRHTTPServerConfiguration.m
//  Criollo
//
//  Created by Cătălin Stan on 10/30/15.
//  Copyright © 2015 Cătălin Stan. All rights reserved.
//

#import "CRHTTPServerConfiguration.h"

// Defaults
static NSTimeInterval const CRHTTPConnectionDefaultReadHeaderTimeout = 2;
static NSTimeInterval const CRHTTPConnectionDefaultReadBodyTimeout = 2;
static size_t const CRRequestDefaultMaxHeaderLength = 20 * 1024;
static size_t const CRRequestDefaultBodyBufferSize = 8 * 1024 * 1024;

// Keys
static NSString * const CRHTTPConnectionReadHeaderTimeoutKey = @"CRHTTPConnectionReadHeaderTimeout";
static NSString * const CRHTTPConnectionReadBodyTimeoutKey = @"CRHTTPConnectionReadBodyTimeout";
static NSString * const CRRequestMaxHeaderLengthKey = @"CRRequestMaxHeaderLength";
static NSString * const CRRequestBodyBufferSizeKey = @"CRRequestBodyBufferSize";

@implementation CRHTTPServerConfiguration

- (void)readConfiguration {
    [super readConfiguration];

    NSBundle* mainBundle = [NSBundle mainBundle];
    if ([mainBundle objectForInfoDictionaryKey:CRHTTPConnectionReadHeaderTimeoutKey]) {
        _CRHTTPConnectionReadHeaderTimeout = [[mainBundle objectForInfoDictionaryKey:CRHTTPConnectionReadHeaderTimeoutKey] doubleValue];
    } else {
        _CRHTTPConnectionReadHeaderTimeout = CRHTTPConnectionDefaultReadHeaderTimeout;
    }
    if ([mainBundle objectForInfoDictionaryKey:CRHTTPConnectionReadBodyTimeoutKey]) {
        _CRHTTPConnectionReadBodyTimeout = [[mainBundle objectForInfoDictionaryKey:CRHTTPConnectionReadBodyTimeoutKey] doubleValue];
    } else {
        _CRHTTPConnectionReadBodyTimeout = CRHTTPConnectionDefaultReadBodyTimeout;
    }

    // Limits
    if ([mainBundle objectForInfoDictionaryKey:CRRequestMaxHeaderLengthKey]) {
        _CRRequestMaxHeaderLength = [[mainBundle objectForInfoDictionaryKey:CRRequestMaxHeaderLengthKey] unsignedLongLongValue];
    } else {
        _CRRequestMaxHeaderLength = CRRequestDefaultMaxHeaderLength;
    }

    // Buffers
    if ([mainBundle objectForInfoDictionaryKey:CRRequestBodyBufferSizeKey]) {
        _CRRequestBodyBufferSize = [[mainBundle objectForInfoDictionaryKey:CRRequestBodyBufferSizeKey] unsignedLongLongValue];
    } else {
        _CRRequestBodyBufferSize = CRRequestDefaultBodyBufferSize;
    }
}

@end
