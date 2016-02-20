//
//  MBXAsyncViewModelProtocol.h
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 20/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MBXAsyncViewModelProtocol <NSObject>
- (void)retrieveDataWithSuccess:(void (^)(void))success AndFailure:(void (^)(NSError *error))failure;
@end
