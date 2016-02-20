//
//  MBXServiceParserProtocol.h
//  sven-10
//
//  Created by Tamara Bernad on 25/09/15.
//  Copyright (c) 2015 moodbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MBXServiceParserProtocol <NSObject>
- (void)processDataArray:(NSArray *)data WithCompletion:(void (^)(id))completion;
- (void)processWithData:(id)data AndCompletion:(void (^)(id result))completion;
@end
