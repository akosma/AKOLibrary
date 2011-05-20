//
//  AKOFileSystemManager.m
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

#import "AKOFileSystemManager.h"
#import "SynthesizeSingleton.h"


@interface AKOFileSystemManager ()

@property (nonatomic, assign) NSFileManager *fileManager;

@end



@implementation AKOFileSystemManager

SYNTHESIZE_SINGLETON_FOR_CLASS(AKOFileSystemManager)

@synthesize fileManager = _fileManager;
@dynamic applicationDocumentsDirectory;

- (id)init
{
    self = [super init];
    if (self)
    {
        _fileManager = [NSFileManager defaultManager];
    }
    return self;
}

- (void)dealloc
{
    _fileManager = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Private methods

- (NSString *)applicationDocumentsDirectory
{
    static NSString *path;
    if (path == nil)
    {
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                             NSUserDomainMask, 
                                                             YES);
        path = [array lastObject];
    }
    return path;
}

@end
