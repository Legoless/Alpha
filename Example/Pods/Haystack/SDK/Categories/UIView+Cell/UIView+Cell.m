//
//  UIView+Cell.m
//

#import "UIView+Hierarchy.h"

#import "UIView+Cell.h"

@implementation UIView (Cell)

- (UITableViewCell *)hay_parentTableViewCell
{
    return (UITableViewCell *) [self hay_parentViewOfType:[UITableViewCell class]];
}

- (UICollectionViewCell *)hay_parentCollectionViewCell
{
    return (UICollectionViewCell *) [self hay_parentViewOfType:[UICollectionViewCell class]];
}

@end
