//
//  CRViewController.m
//  Criollo
//
//  Created by Cătălin Stan on 5/17/14.
//  Copyright (c) 2014 Catalin Stan. All rights reserved.
//

#import <Criollo/CRViewController.h>

#import <Criollo/CRNib.h>
#import <Criollo/CRRequest.h>
#import <Criollo/CRResponse.h>
#import <Criollo/CRView.h>

#import "CRRoute.h"
#import "CRRouter_Internal.h"
#import "Macros.h"
#import "NSString+Criollo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRViewController ()

@property (nonatomic, strong, nonnull, readonly) CRNib* nib;

- (void)loadView;

@end

NS_ASSUME_NONNULL_END

@implementation CRViewController


- (instancetype)init {
    return [self initWithNibName:nil bundle:nil prefix:CRRoutePathSeparator];
}

- (instancetype)initWithPrefix:(NSString *)prefix {
    return [self initWithNibName:nil bundle:nil prefix:prefix];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil prefix:CRRoutePathSeparator];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil prefix:(NSString *)prefix {
    self = [super initWithPrefix:prefix];
    if ( self != nil ) {
        _nibName = nibNameOrNil ? : NSStringFromClass(self.class);
        _nibBundle = nibBundleOrNil ? : [NSBundle mainBundle];
        _vars = [NSMutableDictionary dictionary];

        weakify(self);
        
        CRRouteBlock notFoundBlock = ^(CRRequest *request, CRResponse *response, CRRouteCompletionBlock completion) {
            strongify(self);
            [response setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-type"];
            NSString* output = [self presentViewControllerWithRequest:request response:response];
            if (self.shouldFinishResponse) {
                [response sendString:output];
            } else {
                [response writeString:output];
            }
            
            completion();
        };
        
        self.routeBlock = ^(CRRequest *request, CRResponse *response, CRRouteCompletionBlock completion) {
            strongify(self);
            NSString* requestedPath = request.env[@"DOCUMENT_URI"];
            NSString* requestedRelativePath = [requestedPath pathRelativeToPath:self.prefix separator:CRRoutePathSeparator];
            NSArray<CRRouteMatchingResult * >* routes = [self routesForPath:requestedRelativePath method:request.method];
            [self executeRoutes:routes request:request response:response withCompletion:completion notFoundBlock:notFoundBlock];
        };
    }
    return self;
}

- (void)loadView {
    _nib = [[CRNib alloc] initWithNibNamed:self.nibName bundle:self.nibBundle];
    NSString * contents = [[NSString alloc] initWithBytesNoCopy:(void *)self.nib.data.bytes length:self.nib.data.length encoding:NSUTF8StringEncoding freeWhenDone:NO];

    // Determine the view class to use
    Class viewClass = NSClassFromString([NSStringFromClass(self.class) stringByReplacingOccurrencesOfString:@"Controller" withString:@""]);
    if ( viewClass == nil ) {
        viewClass = [CRView class];
    }
    self.view = [[viewClass alloc] initWithContents:contents];

    //
    [self viewDidLoad];
}

- (void)viewDidLoad {}

- (NSString *)presentViewControllerWithRequest:(CRRequest *)request response:(CRResponse *)response {
    if ( self.view == nil ) {
        [self loadView];
    }
    return [self.view render:self.vars];
}

- (BOOL)shouldFinishResponse {
    return YES;
}

@end
