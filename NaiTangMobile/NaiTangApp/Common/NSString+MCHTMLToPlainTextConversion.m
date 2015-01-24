#import "NSString+MCHTMLToPlainTextConversion.h"


@interface MCHTMLToPlainTextConverter : NSObject <NSXMLParserDelegate>

@property (readonly) NSString *plainText;

-(id)initWithHTMLData:(NSData *)htmlData;

@end


@implementation NSString (MCHTMLToPlainTextConversion)

-(NSString *)stringByConvertingHTMLToPlainText
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    MCHTMLToPlainTextConverter *converter = [[MCHTMLToPlainTextConverter alloc] initWithHTMLData:data];
    return converter.plainText;
}

@end


@implementation MCHTMLToPlainTextConverter {
    NSData *htmlData;
    NSMutableString *accumulatingString;
    NSString *plainText;
    NSXMLParser *parser;
}

-(id)initWithHTMLData:(NSData *)newData
{
    self = [super init];
    if ( self ) {
        htmlData = [newData copy];
	plainText = nil;
    }
    return self;
}

-(NSString *)plainText
{
    if ( !plainText ) {
        accumulatingString = [[NSMutableString alloc] init];
        parser = [[NSXMLParser alloc] initWithData:htmlData];
        parser.delegate = self;
        if ( [parser parse] ) plainText = [NSString stringWithString:accumulatingString];
        accumulatingString = nil;
        parser = nil;
    }
    return plainText;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)s
{
    [accumulatingString appendString:s];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ( [elementName caseInsensitiveCompare:@"br"] == NSOrderedSame ) {
        [accumulatingString appendString:@"\n"];
    }
    else if ( [elementName caseInsensitiveCompare:@"p"] == NSOrderedSame ) {
        [accumulatingString appendString:@"\n"];
    }
}

@end