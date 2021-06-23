//
//  CRServerConfiguration.h
//  Criollo
//
//  Created by Cătălin Stan on 10/25/15.
//  Copyright © 2015 Cătălin Stan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CRServerConfiguration : NSObject

@property (nonatomic, strong) NSString *CRServerInterface;
@property (nonatomic, assign) UInt16 CRServerPort;

@property (nonatomic, assign, readonly) NSTimeInterval CRConnectionReadTimeout;
@property (nonatomic, assign, readonly) NSTimeInterval CRConnectionWriteTimeout;

@property (nonatomic, assign, readonly) NSTimeInterval CRConnectionKeepAliveTimeout;
@property (nonatomic, assign, readonly) NSTimeInterval CRConnectionMaxKeepAliveConnections;

- (void)readConfiguration;

@end
NS_ASSUME_NONNULL_END
