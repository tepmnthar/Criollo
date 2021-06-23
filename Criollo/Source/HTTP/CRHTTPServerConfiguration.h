//
//  CRHTTPServerConfiguration.h
//  Criollo
//
//  Created by Cătălin Stan on 10/30/15.
//  Copyright © 2015 Cătălin Stan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CRServerConfiguration.h"

@interface CRHTTPServerConfiguration : CRServerConfiguration

@property (nonatomic, assign, readonly) NSTimeInterval CRHTTPConnectionReadHeaderTimeout;
@property (nonatomic, assign, readonly) NSTimeInterval CRHTTPConnectionReadBodyTimeout;

@property (nonatomic, assign, readonly) size_t CRRequestMaxHeaderLength;

@property (nonatomic, assign, readonly) size_t CRRequestBodyBufferSize;

@end
