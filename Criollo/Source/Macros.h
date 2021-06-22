//
//  Macros.h
//  Criollo
//
//  Created by Cătălin Stan on 22/06/2021.
//  Copyright © 2021 Cătălin Stan. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define weakify(var) __weak typeof(var) __cr_weak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = __cr_weak_##var; \
_Pragma("clang diagnostic pop")

#define CR_OBJC_ABSTRACT {\
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%s must be implemented in a subclass.", __PRETTY_FUNCTION__] userInfo:nil];\
}

#define CR_OBJC_DIRECT __attribute__((objc_direct))
#define CR_OBJC_DIRECT_MEMBERS __attribute__((objc_direct_members))


#endif /* Macros_h */
