#import "HAYWeakPointer.h"

@implementation HAYWeakPointer

- (BOOL)isValid
{
    return (self.object != nil);
}

+ (instancetype)weakPointerWithObject:(id)object
{
    HAYWeakPointer * pointer = [[[self class] alloc] init];
    pointer.object = object;
    
    return pointer;
}

@end
