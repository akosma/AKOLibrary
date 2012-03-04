//
//  AKORSSRequest.m
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

#import "AKORSSRequest.h"
#import "TBXML.h"
#import "AKOLibrary_Managers_notifications.h"

static NSString *AKORSSRequestTagName = @"item";
static NSString *AKORSSRequestTagDate = @"pubDate";
static NSString *AKORSSRequestTagTitle = @"title";
static NSString *AKORSSRequestTagDescription = @"description";
static NSString *AKORSSRequestTagLink = @"link";
static NSString *AKORSSRequestTagChannel = @"channel";

@implementation AKORSSRequest

- (id)processResponse
{
    NSData *data = [self responseData];
    TBXML *tbxml = [TBXML tbxmlWithXMLData:data error:nil];
    TBXMLElement *root = tbxml.rootXMLElement;
    NSMutableArray *newsItems = [NSMutableArray array];
    if (root) 
    {
        TBXMLElement *channelTag = [TBXML childElementNamed:AKORSSRequestTagChannel 
                                              parentElement:root];
        if (channelTag)
        {
            TBXMLElement *newsTag = [TBXML childElementNamed:AKORSSRequestTagName 
                                               parentElement:channelTag];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
            while (newsTag != nil)
            {
                TBXMLElement *dateTag = [TBXML childElementNamed:AKORSSRequestTagDate 
                                                   parentElement:newsTag];
                TBXMLElement *titleTag = [TBXML childElementNamed:AKORSSRequestTagTitle 
                                                    parentElement:newsTag];
                TBXMLElement *descriptionTag = [TBXML childElementNamed:AKORSSRequestTagDescription 
                                                          parentElement:newsTag];
                TBXMLElement *linkTag = [TBXML childElementNamed:AKORSSRequestTagLink 
                                                   parentElement:newsTag];
                
                NSString *dateText = [TBXML textForElement:dateTag];
                NSString *titleText = [TBXML textForElement:titleTag];
                NSString *descriptionText = [TBXML textForElement:descriptionTag];
                NSString *linkText = [TBXML textForElement:linkTag];
                
                NSDate *date = [formatter dateFromString:dateText];
                
                NSMutableDictionary *item = [NSMutableDictionary dictionary];
                [item setObject:date 
                         forKey:AKONetworkManagerDateKey];
                [item setObject:titleText 
                         forKey:AKONetworkManagerTitleKey];
                [item setObject:descriptionText 
                         forKey:AKONetworkManagerTextKey];
                [item setObject:linkText 
                         forKey:AKONetworkManagerLinkKey];
                [newsItems addObject:item];
                
                newsTag = [TBXML nextSiblingNamed:AKORSSRequestTagName 
                                searchFromElement:newsTag];
            }
            [formatter release];
        }
    }
    return newsItems;
}

@end
