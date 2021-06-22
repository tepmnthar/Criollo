//
//  CRRouteController.m
//  Criollo
//
//  Created by Cătălin Stan on 19/07/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

#import <Criollo/CRRouteController.h>

#import <Criollo/CRRequest.h>
#import <Criollo/CRResponse.h>

#import "CRRequest_Internal.h"
#import "CRResponse_Internal.h"
#import "CRRoute.h"
#import "CRRouteMatchingResult.h"
#import "CRRouter_Internal.h"
#import "Macros.h"
#import "NSString+Criollo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRRouteController ()

@end

NS_ASSUME_NONNULL_END

@implementation CRRouteController

- (instancetype)init {
    return [self initWithPrefix:CRRoutePathSeparator];
}

- (instancetype)initWithPrefix:(NSString *)prefix {
    self = [super init];
    if ( self != nil ) {
        _prefix = prefix;
        
        weakify(self);
        _routeBlock = ^(CRRequest *request, CRResponse *response, CRRouteCompletionBlock completion) {
            strongify(self);
            NSString *requestedPath = request.env[@"DOCUMENT_URI"];
            NSString *requestedRelativePath = [requestedPath pathRelativeToPath:self.prefix separator:CRRoutePathSeparator];
            NSArray<CRRouteMatchingResult *>* routes = [self routesForPath:requestedRelativePath method:request.method];
            [self executeRoutes:routes request:request response:response withCompletion:completion];
        };
    }
    return self;
}
@end
