//
//  UrlEntity.m
//  Pods
//
//  Created by jiaguoshang on 18/9/30.
//
//

#import "UrlEntity.h"

@interface UrlEntity ()
/**
 *  scheme
 */
@property (strong, nonatomic) NSString *scheme;

/**
 *  host
 */
@property (strong, nonatomic) NSString *host;

/**
 *  path
 */
@property (strong, nonatomic) NSString *path;

/**
 *  URL 中的参数列表
 */
@property (strong, nonatomic) NSDictionary *params;

/**
 *  URL String
 */
@property (strong, nonatomic) NSString *absoluteString;

@end

@implementation UrlEntity

+ (instancetype)URLWithString:(NSString *)urlString
{
    if (!urlString) {
        return nil;
    }
    
    UrlEntity *url = [[UrlEntity alloc] init];
    
    NSString *protocolString = @"";
    NSString *tmpString = @"";
    NSString *hostString = @"";
    NSString *uriString = @"/";
    
    if (NSNotFound != [urlString rangeOfString:@"://"].location) {
        protocolString = [urlString substringToIndex:([urlString rangeOfString:@"://"].location)];
        tmpString = [urlString substringFromIndex:([urlString rangeOfString:@"://"].location + 3)];
    }
    
    NSInteger slashLocation = [tmpString rangeOfString:@"/"].location;
    NSInteger questionLocation = [tmpString rangeOfString:@"?"].location;
    
    if ((NSNotFound != slashLocation && NSNotFound != questionLocation && slashLocation < questionLocation) || (NSNotFound != slashLocation && NSNotFound == questionLocation)) {
        if([protocolString isEqualToString:@"file"]){
            hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"/" options:NSBackwardsSearch].location)];
        }
        else{
            hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"/"].location)];
        }
        
        tmpString = [urlString substringFromIndex:([urlString rangeOfString:hostString].location + [urlString rangeOfString:hostString].length)];
    }
    else if ((NSNotFound != slashLocation && NSNotFound != questionLocation && slashLocation > questionLocation) || (NSNotFound == slashLocation && NSNotFound != questionLocation)) {
        hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"?"].location)];
        if (0 < hostString.length) {
            tmpString = [urlString substringFromIndex:([urlString rangeOfString:hostString].location + [urlString rangeOfString:hostString].length)];
        }
    }
    else {
        hostString = tmpString;
        tmpString = nil;
    }
    
    if (tmpString) {
        if (NSNotFound != [tmpString rangeOfString:@"/"].location) {
            if (NSNotFound != [tmpString rangeOfString:@"?"].location) {
                uriString = [tmpString substringToIndex:[tmpString rangeOfString:@"?"].location];
            }
            else {
                uriString = tmpString;
            }
        }
    }
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [urlString rangeOfString:@"?"].location) {
        NSString *paramString = [urlString substringFromIndex:([urlString rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSInteger location = [pairString rangeOfString:@"="].location;
            if (location != NSNotFound) {
                NSString *key = [[pairString substringToIndex:location] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *value = [[pairString substringFromIndex:location+1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                if (key && value) {
                    [pairs setObject:value forKey:key];
                }
            }
        }
    }
    
    NSString* path = [NSString stringWithString:[uriString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    for (; [path length] >0 && [path characterAtIndex:0] == '/'; path = [path substringFromIndex:1]);
    
    if ([path isEqualToString:@"/"]) {
        path = @"";
    }
    
    
    url.scheme = protocolString;
    url.host = hostString;
    url.path = path;
    url.params = pairs;
    url.absoluteString = urlString;
    return url;
}




@end
