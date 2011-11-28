//  RXSynchronously.h
//  Created by Rob Rix on 11-11-27.
//  Copyright (c) 2011 Monochrome Industries. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^RXSynchronousCompletionBlock)();
typedef void (^RXSynchronousBlock)(RXSynchronousCompletionBlock);

/*
 RXSynchronously
 */

void RXSynchronously(RXSynchronousBlock block); // never times out
void RXSynchronouslyWithTimeout(dispatch_time_t timeout, RXSynchronousBlock block);
