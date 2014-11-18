//
//  UIView+Cell.m
//

#import "UIView+Hierarchy.h"

#import "UIView+Cell.h"

@implementation UIView (Cell)

- (UITableViewCell *)parentTableViewCell
{
    return (UITableViewCell *)[self parentViewOfType:[UITableViewCell class]];
}

- (UICollectionViewCell *)parentCollectionViewCell
{
    return (UICollectionViewCell *)[self parentViewOfType:[UICollectionViewCell class]];
}

@end
