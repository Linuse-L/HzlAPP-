#import <Foundation/Foundation.h>

@interface SecureUDID : NSObject

+ (NSString *)UDIDForDomain:(NSString *)domain usingKey:(NSString *)key;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 40000
+ (void)retrieveUDIDForDomain:(NSString *)domain usingKey:(NSString *)key completion:(void (^)(NSString* identifier))completion;
#endif

/*
 Indicates that the system has been disabled via the Opt-Out mechansim.
*/
+ (BOOL)isOptedOut;

@end

/*
 This identifier is returned when Opt-Out is enabled.
 */
extern NSString *const SUUIDDefaultIdentifier;
