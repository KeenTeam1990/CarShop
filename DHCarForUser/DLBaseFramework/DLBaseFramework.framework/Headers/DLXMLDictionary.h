//
//  DLXMLDictionary.h
//


#import <Foundation/Foundation.h>
#import "DLSingleton.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wobjc-missing-property-synthesis"


typedef NS_ENUM(NSInteger, DLXMLDictionaryAttributesMode)
{
    DLXMLDictionaryAttributesModePrefixed = 0, //default
    DLXMLDictionaryAttributesModeDictionary,
    DLXMLDictionaryAttributesModeUnprefixed,
    DLXMLDictionaryAttributesModeDiscard
};


typedef NS_ENUM(NSInteger, DLXMLDictionaryNodeNameMode)
{
    DLXMLDictionaryNodeNameModeRootOnly = 0, //default
    DLXMLDictionaryNodeNameModeAlways,
    DLXMLDictionaryNodeNameModeNever
};


static NSString *const DLXMLDictionaryAttributesKey   = @"__attributes";
static NSString *const DLXMLDictionaryCommentsKey     = @"__comments";
static NSString *const DLXMLDictionaryTextKey         = @"__text";
static NSString *const DLXMLDictionaryNodeNameKey     = @"__name";
static NSString *const DLXMLDictionaryAttributePrefix = @"_";


@interface DLXMLDictionaryParser : NSObject <NSCopying>

AS_SINGLETON(DLXMLDictionaryParser);

@property (nonatomic, assign) BOOL collapseTextNodes; // defaults to YES
@property (nonatomic, assign) BOOL stripEmptyNodes;   // defaults to YES
@property (nonatomic, assign) BOOL trimWhiteSpace;    // defaults to YES
@property (nonatomic, assign) BOOL alwaysUseArrays;   // defaults to NO
@property (nonatomic, assign) BOOL preserveComments;  // defaults to NO
@property (nonatomic, assign) BOOL wrapRootNode;      // defaults to NO

@property (nonatomic, assign) DLXMLDictionaryAttributesMode attributesMode;
@property (nonatomic, assign) DLXMLDictionaryNodeNameMode nodeNameMode;

- (NSDictionary *)dictionaryWithParser:(NSXMLParser *)parser;
- (NSDictionary *)dictionaryWithData:(NSData *)data;
- (NSDictionary *)dictionaryWithString:(NSString *)string;
- (NSDictionary *)dictionaryWithFile:(NSString *)path;

@end


@interface NSDictionary (DLXMLDictionary)

+ (NSDictionary *)dictionaryWithXMLParser:(NSXMLParser *)parser;
+ (NSDictionary *)dictionaryWithXMLData:(NSData *)data;
+ (NSDictionary *)dictionaryWithXMLString:(NSString *)string;
+ (NSDictionary *)dictionaryWithXMLFile:(NSString *)path;

- (NSDictionary *)attributes;
- (NSDictionary *)childNodes;
- (NSArray *)comments;
- (NSString *)nodeName;
- (NSString *)innerText;
- (NSString *)innerXML;
- (NSString *)XMLString;

- (NSArray *)arrayValueForKeyPath:(NSString *)keyPath;
- (NSString *)stringValueForKeyPath:(NSString *)keyPath;
- (NSDictionary *)dictionaryValueForKeyPath:(NSString *)keyPath;

@end


@interface NSString (DLXMLDictionary)

- (NSString *)XMLEncodedString;

@end


#pragma GCC diagnostic pop
