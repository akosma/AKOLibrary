//
//  AKOLibrary_Managers_notifications.h
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this list 
//  of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this 
//  list of conditions and the following disclaimer in the documentation and/or 
//  other materials provided with the distribution.
//  Neither the name of the akosma software nor the names of its contributors may be 
//  used to endorse or promote products derived from this software without specific 
//  prior written permission.
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

/**
 @file AKOLibrary_Managers_notifications.h
 Definition of several notifications used throughout the library.
 */

#import <Foundation/Foundation.h>


/**
 @name Notifications
 @{
 */

/**
 Notification sent when the Reachability component detects a change of network status.
 */
extern NSString * const AKONetworkManagerConnectivityChangedNotification;

/**
 Notification sent whenever a network connection fails.
 */
extern NSString * const AKONetworkManagerDidFailWithErrorNotification;

/**
 @}
 @name User Info Dictionary Keys
 */

/**
 Key used in userinfo dictionaries to signal errors.
 The value held by this key is an NSError instance.
 */
extern NSString * const AKONetworkManagerErrorKey;

/**
 Key used in userinfo dictionaries to hold URLs.
 The value held by this key is an NSURL instance.
 */
extern NSString * const AKONetworkManagerURLKey;

/**
 Key used in userinfo dictionaries to hold dates.
 The value held by this key is an NSDate instance.
 */
extern NSString * const AKONetworkManagerDateKey;

/**
 Key used in userinfo dictionaries to hold titles.
 The value held by this key is an NSString instance.
 */
extern NSString * const AKONetworkManagerTitleKey;

/**
 Key used in userinfo dictionaries to hold texts.
 The value held by this key is an NSString instance.
 */
extern NSString * const AKONetworkManagerTextKey;

/**
 Key used in userinfo dictionaries to hold links.
 The value held by this key is an NSString instance.
 */
extern NSString * const AKONetworkManagerLinkKey;

/**
 @}
 */
