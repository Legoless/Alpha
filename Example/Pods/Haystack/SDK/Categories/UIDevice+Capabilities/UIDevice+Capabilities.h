//
//  UIDevice+Capabilities.h
//

/*!
 * Category displays detailed information about current device capabilities
 */
@interface UIDevice (Capabilities)

/*!
 * Returns YES if device supports Touch ID sensor
 */
- (BOOL)hasTouchID;

/**
 *  Returns YES if device has Retina or Retina HD display
 *
 *  @return YES if device is running on Retina (scale of 2.0 or more) display
 */
- (BOOL)hasRetina;

@end
