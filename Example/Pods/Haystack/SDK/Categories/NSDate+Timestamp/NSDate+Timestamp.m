//
//  NSDate+Timestamp.m
//

#import "NSDate+Timestamp.h"

@implementation NSDate (Timestamp)

+ (NSTimeInterval)hay_unixTimestampFromDate:(NSDate *)date
{
    return [date timeIntervalSince1970];
}

+ (NSTimeInterval)hay_timeIntervalUntilUnixTimeStamp:(NSTimeInterval)timestamp;
{
    NSDate *timeStampDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    return [timeStampDate timeIntervalSinceNow];
}

- (NSTimeInterval)hay_unixTimestamp
{
    return [self timeIntervalSince1970];
}

+ (NSDate *)hay_dateWithUnixTimestamp:(NSTimeInterval)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

+ (NSTimeInterval)hay_unixTimestampForToday
{
    return [self hay_unixTimestampDayForDate:[NSDate date]];
}

+ (NSTimeInterval)hay_unixTimestampDayForDate:(NSDate *)date
{
    NSTimeInterval timestamp = [self hay_unixTimestampFromDate:date];
    
    //
    // Cut away seconds and hours and milliseconds
    //
    
    NSInteger seconds = timestamp;
    
    seconds = seconds / 86400;
    
    seconds = seconds * 86400;
    
    return (NSTimeInterval)seconds;
}

@end
