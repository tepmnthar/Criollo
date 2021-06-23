//
//  CRServerConfiguration.m
//  Criollo
//
//  Created by Cătălin Stan on 10/25/15.
//  Copyright © 2015 Cătălin Stan. All rights reserved.
//

#import "CRServerConfiguration.h"

// Defaults
static NSString * const CRServerDefaultInterface = @"";
static UInt16 const CRServerDefaultPort = 10781;
static NSTimeInterval const CRConnectionDefaultReadTimeout = 5.;
static NSTimeInterval const CRConnectionDefaultWriteTimeout = 5.;
static NSTimeInterval const CRConnectionDefaultKeepAliveTimeout = 15.;
static NSTimeInterval const CRConnectionDefaultMaxKeepAliveConnections = 10.;

// Keys
static NSString * const CRServerInterfaceKey = @"CRServerInterface";
static NSString * const CRServerPortKey = @"CRServerPort";
static NSString * const CRConnectionReadTimeoutKey = @"CRConnectionReadTimeoutKey";
static NSString * const CRConnectionWriteTimeoutKey = @"CRConnectionWriteTimeoutKey";
static NSString * const CRConnectionKeepAliveTimeoutKey = @"CRConnectionKeepAliveTimeout";
static NSString * const CRConnectionMaxKeepAliveConnectionsKey = @"CRConnectionMaxKeepAliveConnections";

@implementation CRServerConfiguration

- (instancetype) init {
    self = [super init];
    if (self) {
        _CRServerInterface = CRServerDefaultInterface;
        _CRServerPort = CRServerDefaultPort;
        _CRConnectionReadTimeout = CRConnectionDefaultReadTimeout;
        _CRConnectionWriteTimeout = CRConnectionDefaultWriteTimeout;
        
        [self readConfiguration];
    }
    return self;
}

- (void)readConfiguration {

    NSBundle* mainBundle = [NSBundle mainBundle];
    NSUserDefaults *args = [NSUserDefaults standardUserDefaults];

    // Interface
    NSString *interface = [args stringForKey:@"i"];
    if (interface.length == 0) {
        interface = [args stringForKey:@"interface"];
        if (interface.length == 0 && [mainBundle objectForInfoDictionaryKey:CRServerInterfaceKey] ) {
            interface = [mainBundle objectForInfoDictionaryKey:CRServerInterfaceKey];
        }
    }
    if (interface.length != 0) {
        _CRServerInterface = interface;
    }

    // Port
    UInt16 portNumber = [[args objectForKey:@"p"] unsignedShortValue];
    if (portNumber == 0) {
        portNumber = [[args objectForKey:@"port"] unsignedShortValue];
        if (portNumber == 0 && [mainBundle objectForInfoDictionaryKey:CRServerPortKey]) {
            portNumber = [[mainBundle objectForInfoDictionaryKey:CRServerPortKey] unsignedShortValue];
        }
    }
    if (portNumber != 0) {
        _CRServerPort = portNumber;
    }

    // Timeouts
    if ([mainBundle objectForInfoDictionaryKey:CRConnectionReadTimeoutKey]) {
        _CRConnectionReadTimeout = [[mainBundle objectForInfoDictionaryKey:CRConnectionReadTimeoutKey] doubleValue];
    } else {
        _CRConnectionReadTimeout = CRConnectionDefaultReadTimeout;
    }
    if ([mainBundle objectForInfoDictionaryKey:CRConnectionWriteTimeoutKey]) {
        _CRConnectionWriteTimeout = [[mainBundle objectForInfoDictionaryKey:CRConnectionWriteTimeoutKey] doubleValue];
    } else {
        _CRConnectionWriteTimeout = CRConnectionDefaultWriteTimeout;
    }


    // Keep alive
    if ([mainBundle objectForInfoDictionaryKey:CRConnectionKeepAliveTimeoutKey] ) {
        _CRConnectionKeepAliveTimeout = [[mainBundle objectForInfoDictionaryKey:CRConnectionKeepAliveTimeoutKey] doubleValue];
    } else {
        _CRConnectionKeepAliveTimeout = CRConnectionDefaultKeepAliveTimeout;
    }
    if ([mainBundle objectForInfoDictionaryKey:CRConnectionMaxKeepAliveConnectionsKey] ) {
        _CRConnectionMaxKeepAliveConnections = [[mainBundle objectForInfoDictionaryKey:CRConnectionMaxKeepAliveConnectionsKey] doubleValue];
    } else {
        _CRConnectionMaxKeepAliveConnections = CRConnectionDefaultMaxKeepAliveConnections;
    }
}

@end
