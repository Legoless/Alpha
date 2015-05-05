//
//  NSData+Base64.m
//

#import "NSData+Base64.h"

@implementation NSData (Base64)

- (NSString *)base64String
{
    
    const uint8_t *input = self.bytes;
    NSInteger length = self.length;
    
    // List of character that are fine
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    // Data object to fill with characters
    NSMutableData *data = [NSMutableData dataWithLength:(NSUInteger) (((length + 2) / 3) * 4)];
    uint8_t *output = (uint8_t *) data.mutableBytes;
    
    // Loop through the string wrapping clean characters
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] = (uint8_t) table[(value >> 18) & 0x3F];
        output[index + 1] = (uint8_t) table[(value >> 12) & 0x3F];
        output[index + 2] = (uint8_t) ((i + 1) < length ? table[(value >> 6) & 0x3F] : '=');
        output[index + 3] = (uint8_t) ((i + 2) < length ? table[(value >> 0) & 0x3F] : '=');
    }
    
    // Return the encoded string
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
