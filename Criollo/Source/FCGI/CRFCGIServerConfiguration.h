//
//  CRFCGIServerConfiguration.h
//  Criollo
//
//  Created by Cătălin Stan on 10/30/15.
//  Copyright © 2015 Cătălin Stan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CRServerConfiguration.h"

@interface CRFCGIServerConfiguration : CRServerConfiguration

@property (nonatomic, assign, readonly) NSTimeInterval CRFCGIConnectionReadRecordTimeout;
@property (nonatomic, assign, readonly) size_t CRFCGIConnectionSocketWriteBuffer;

@end
