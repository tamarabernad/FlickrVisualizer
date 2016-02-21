//
//  MBXMappedParser.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 21/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import "MBXMappedParser.h"
@interface MBXMappedParser()
@property(nonatomic, strong) NSDictionary *mapping;
@end
@implementation MBXMappedParser
+ (instancetype)newParserWithModelClass:(Class)modelClass andMapping:(NSDictionary *)mapping{
    return [[[self class] alloc] initWithModelClass:modelClass andMapping:mapping];
}
- (instancetype)initWithModelClass:(Class)modelClass andMapping:(NSDictionary *)mapping{
    if(!(self == [super initWithModelClass:modelClass]))return self;
    
    self.mapping = mapping;
    return self;
}
- (void)processWithData:(id)data AndCompletion:(void (^)(id))completion{
    id object = [[self.modelClass alloc] init];
    //TODO: combine mapped parser with automatic parser (base parser) so that direct mapped properties dont' need to be specified in mapping
    NSDictionary *objectData = (NSDictionary *)data;
    for (NSString *key in [self.mapping allKeys]) {
        if ([object respondsToSelector:NSSelectorFromString(key)] ) {
            id objectDataValue = [objectData valueForKeyPath:[self.mapping valueForKey:key]];
            if([objectDataValue isEqual:[NSNull null]]){
                [object setValue:nil forKey:key];
            }else{
                [object setValue:objectDataValue forKey:key];
            }
        }
    }
    if(completion)completion(object);
}
@end
