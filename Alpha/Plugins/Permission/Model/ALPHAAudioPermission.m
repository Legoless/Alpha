//
//  ALPHAAudioPermission.m
//  Alpha
//
//  Created by Dal Rupnik on 03/10/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

@import AVFoundation;

#import "ALPHAAudioPermission.h"

@interface ALPHAAudioPermission ()

@property (nonatomic, strong) AVAudioSession *audioSession;

@end

@implementation ALPHAAudioPermission

#pragma mark - Getters and Setters

- (AVAudioSession *)audioSession
{
    if (!_audioSession)
    {
        _audioSession = [AVAudioSession sharedInstance];
    }
    
    return _audioSession;
}

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithIdentifier:@"com.unifiedsense.alpha.data.permission.audio"];
}

#pragma mark - Public Methods

- (NSString *)name
{
    return @"Microphone";
}

- (ALPHAApplicationAuthorizationStatus)status
{
    switch (self.audioSession.recordPermission)
    {
        case AVAudioSessionRecordPermissionUndetermined:
            return ALPHAApplicationAuthorizationStatusNotDetermined;
        case AVAudioSessionRecordPermissionDenied:
            return ALPHAApplicationAuthorizationStatusDenied;
        case AVAudioSessionRecordPermissionGranted:
            return ALPHAApplicationAuthorizationStatusAuthorized;
    }
}

- (void)requestPermission:(ALPHAPermissionRequestCompletion)completion
{
    [self.audioSession requestRecordPermission:^(BOOL granted)
    {
        if (completion)
        {
            completion(self, (granted) ? ALPHAApplicationAuthorizationStatusAuthorized : ALPHAApplicationAuthorizationStatusDenied, nil);
        }
    }];
}

@end
