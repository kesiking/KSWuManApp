//
//  UIView+Geometry.h
//  TBUtility
//
//  Created by lv on 14-4-2.
//
//

#import <UIKit/UIKit.h>

/**
 * 移入plugin中 TB_UIViewAdditions.h
 */
@interface UIView (Geometry)
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (UIViewController*)viewController;
- (UIView*)descendantOrSelfWithClass:(Class)cls;
- (UIView*)ancestorOrSelfWithClass:(Class)cls;
- (void)removeAllSubviews;

@end
