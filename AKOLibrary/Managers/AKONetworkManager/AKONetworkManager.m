//
//  AKONetworkManager.m
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

#import "AKONetworkManager.h"
#import "AKOLibrary_Managers_notifications.h"
#import "SynthesizeSingleton.h"
#import "ASINetworkQueue.h"
#import "AKOBaseRequest.h"
#import "Reachability.h"

@implementation AKONetworkManager

SYNTHESIZE_SINGLETON_FOR_CLASS(AKONetworkManager)

@synthesize networkQueue = _networkQueue;
@synthesize notificationCenter = _notificationCenter;
@synthesize reachability = _reachability;
@synthesize connectivity = _connectivity;
@synthesize connectionAvailable = _connectionAvailable;

- (id)init
{
    self = [super init];
    if (self)
    {
        _notificationCenter = [NSNotificationCenter defaultCenter];
        
        NSString *hostname = [self baseHostname];
        NSAssert(hostname, @"You have to implement baseHostname in your subclass!");
        _reachability = [[Reachability reachabilityWithHostName:hostname] retain];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:) 
                                                     name:kReachabilityChangedNotification 
                                                   object:_reachability];
        
        _connectivity = (AKONetworkManagerConnectivity)[self.reachability currentReachabilityStatus];
        _connectionAvailable = (self.connectivity != AKONetworkManagerConnectivityNone);
        [_reachability startNotifier];
        
        _networkQueue = [[ASINetworkQueue alloc] init];
        _networkQueue.shouldCancelAllRequestsOnFailure = NO;
        _networkQueue.delegate = self;
        _networkQueue.requestDidFinishSelector = @selector(requestDone:);
        _networkQueue.requestDidFailSelector = @selector(requestWentWrong:);
        _networkQueue.queueDidFinishSelector = @selector(queueFinished:);
        [_networkQueue go];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:kReachabilityChangedNotification
                                                  object:_reachability];
    [_networkQueue release];
    _networkQueue = nil;
    [_reachability release];
    _reachability = nil;
    
    [super dealloc];
}

#pragma mark - Methods to override

- (NSString *)baseHostname
{
    return nil;
}

#pragma mark - NSNotification methods

- (void)reachabilityChanged:(NSNotification *)notification
{
    self.connectivity = (AKONetworkManagerConnectivity)[self.reachability currentReachabilityStatus];
    self.connectionAvailable = (self.connectivity != AKONetworkManagerConnectivityNone);
    
    [self.notificationCenter postNotificationName:AKONetworkManagerConnectivityChangedNotification
                                           object:self];
}

#pragma mark - Public methods

- (void)sendRequest:(AKOBaseRequest *)request
{
    if (self.isConnectionAvailable)
    {
        [self.networkQueue addOperation:request];
    }
}

- (void)notifyError:(NSError *)error forURL:(NSURL *)url
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:error, AKONetworkManagerErrorKey,
                              url, AKONetworkManagerURLKey, nil];
    NSNotification *notif = [NSNotification notificationWithName:AKONetworkManagerDidFailWithErrorNotification 
                                                          object:self 
                                                        userInfo:userInfo];
    [self.notificationCenter postNotification:notif];    
}

#pragma mark -
#pragma mark ASINetworkQueue delegate methods

- (void)requestDone:(AKOBaseRequest *)request
{
    NSInteger code = [request responseStatusCode];
    
    if (code == 200)
    {
        [request handleResponse];
    }
    else if (code >= 500)
    {
        NSError *error = [NSError errorWithDomain:@"Server error" code:code userInfo:nil];
        NSURL *url = request.url;
        [self notifyError:error forURL:url];
    }
}

- (void)requestWentWrong:(AKOBaseRequest *)request
{
    NSError *error = [request error];
    NSURL *url = request.url;
    [self notifyError:error 
               forURL:url];
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
}

@end
