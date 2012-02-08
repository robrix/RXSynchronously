//  RXSynchronously.m
//  Created by Rob Rix on 11-11-27.
//  Copyright (c) 2011 Monochrome Industries. All rights reserved.

#import "RXSynchronously.h"

void RXSynchronously(RXSynchronousBlock block) {
	RXSynchronouslyWithTimeout(DISPATCH_TIME_FOREVER, block);
}

void RXSynchronouslyWithTimeout(dispatch_time_t timeout, RXSynchronousBlock block) {
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	
	block(^{
		dispatch_semaphore_signal(semaphore);
	});
	
	dispatch_semaphore_wait(semaphore, timeout);
	dispatch_release(semaphore);
}


void RXSpinSynchronously(RXSynchronousBlock block) {
	RXSpinSynchronouslyWithTimeout([NSDate distantFuture], block);
}

void RXSpinSynchronouslyWithTimeout(NSDate *endDate, RXSynchronousBlock block) {
	__block BOOL done = NO;
	
	block(^{
		done = YES;
	});
	
	while(!done && ([[NSDate date] laterDate:endDate] == endDate)) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
	}
}
