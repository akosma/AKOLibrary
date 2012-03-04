//
//  AKOBaseRequest.m
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Use in source and/or binary forms without modification is permitted following the
//  instructions in the LICENSE file.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "AKOBaseRequest.h"
#import "NXJsonParser.h"
#import "AKOLibrary_Foundation_functions.h"
#import "UIDevice+AKOLibrary.h"

NSTimeInterval const AKOBaseRequestTimeout = 60;
static NSString *AKOBaseRequestHeaderApplicationVersionKey = @"AKOBaseRequestHeaderApplicationVersionKey";
static NSString *AKOBaseRequestHeaderOSVersionKey = @"AKOBaseRequestHeaderOSVersionKey";
static NSString *AKOBaseRequestHeaderDeviceKindKey = @"AKOBaseRequestHeaderDeviceKindKey";

@interface AKOBaseRequest ()

- (NSString *)basicDescription;

@end


@implementation AKOBaseRequest

- (id)initWithURL:(NSURL *)newURL
{
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:newURL];
    self = [super initWithRequest:request];
    if (self)
    {
        // Set some request headers for having information about
        // the current client, software versions and device kind
        NSString *appVersion = AKOCurrentVersionNumber();
        NSString *systemVersion = [UIDevice currentDevice].systemVersion;
        NSString *hardware = [[UIDevice currentDevice] ako_platformString];
        
        [request setValue:appVersion forHTTPHeaderField:AKOBaseRequestHeaderApplicationVersionKey];
        [request setValue:systemVersion forHTTPHeaderField:AKOBaseRequestHeaderOSVersionKey];
        [request setValue:hardware forHTTPHeaderField:AKOBaseRequestHeaderDeviceKindKey];
    }
    return self;
}

#pragma mark - Public methods

- (void)handleResponse
{
    // This is a template method, calling the polymorphic
    // implementations of these two methods in subclasses.
    id result = [self processResponse];
    [self notifyResult:result];
}

- (NSString *)description
{
    NSMutableString *result = [NSMutableString stringWithString:@"REQUEST:\n"];
    [result appendString:[self basicDescription]];
    return result;
}

- (NSString *)responseDescription
{
    NSMutableString *result = [NSMutableString stringWithFormat:@"RESPONSE CODE %d:\n", [self.response statusCode]];
    [result appendString:[self basicDescription]];
    
    NSString *response = [self responseString];
    if (response == nil)
    {
        [result appendString:@"(binary data)"];
    }
    else
    {
        [result appendString:response];
    }
    return result;
}

#pragma mark -
#pragma mark Methods overridden by subclasses

- (id)processResponse
{
    NSData *data = [self responseData];
    NSDictionary *dict = [NXJsonParser parseData:data error:nil ignoreNulls:YES];
    return dict;
}

- (void)notifyResult:(id)result
{
    // Overridden by subclasses 
}

#pragma mark -
#pragma mark Private methods

- (NSString *)basicDescription
{
    return [NSString stringWithFormat:@"%@ (%@)\n", NSStringFromClass([self class]), [[self.request URL] absoluteString]];
}

@end
