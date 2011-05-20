//
//  AKOFullScreenVideoController.m
//  AKOLibrary
//
//  Created by Adrian on 5/20/11.
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

#import "AKOFullScreenVideoController.h"

@interface AKOFullScreenVideoController ()

@property (nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end


@implementation AKOFullScreenVideoController

@synthesize moviePlayer = _moviePlayer;
@synthesize movieFileName = _movieFileName;

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];

    [_moviePlayer release];
    [_movieFileName release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:self.movieFileName ofType:@""];
    if (path != nil)
    {
        self.moviePlayer = [[[MPMoviePlayerController alloc] init] autorelease];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self 
                   selector:@selector(movieReady:) 
                       name:MPMoviePlayerLoadStateDidChangeNotification
                     object:self.moviePlayer];
        
        [center addObserver:self 
                   selector:@selector(moviePlaybackFinished:) 
                       name:MPMoviePlayerPlaybackDidFinishNotification
                     object:self.moviePlayer];
        
        self.moviePlayer.backgroundView.backgroundColor = [UIColor blackColor];
        self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        self.moviePlayer.controlStyle = MPMovieControlModeDefault;
        self.moviePlayer.view.frame = self.view.bounds;
        
        NSURL *url = [NSURL fileURLWithPath:path];
        self.moviePlayer.contentURL = url;
        
        [self.view addSubview:self.moviePlayer.view];
        self.view.alpha = 0.0;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - NSNotification handlers

- (void)movieReady:(NSNotification *)notification
{
    if (self.moviePlayer.loadState == 3)
    {
        self.view.alpha = 1.0;
        [self.moviePlayer play];
    }
}

- (void)moviePlaybackFinished:(NSNotification *)notification
{
    [UIView animateWithDuration:0.4 
                     animations:^{
                         self.moviePlayer.view.alpha = 0.0;
                     }];
}


@end
