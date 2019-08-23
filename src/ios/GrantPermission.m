/********* GrantPermission.m Cordova Plugin Implementation *******/

#import <Cordova/CDVPlugin.h>
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>

@interface GrantPermission : CDVPlugin {
  // Member variables go here.
}

@end

@implementation GrantPermission

- (void)grantNotificationPermission:(CDVInvokedUrlCommand*)command
{
    // [self.commandDelegate runInBackground:^{
    //     // do work here
        
    // }];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            NSLog(@"grant notification");
            if (granted) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    
}

- (void)grantCameraPermission:(CDVInvokedUrlCommand*)command
{
//    [self.commandDelegate runInBackground:^{
//        
//    }];
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusNotDetermined){ // not determined
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            //
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)isGrantPermission:(CDVInvokedUrlCommand*)command {
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        switch (settings.authorizationStatus) {
                // This means we have not yet asked for notification permissions
            case UNAuthorizationStatusNotDetermined:
            {
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:false];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
                break;
                // We are already authorized, so no need to ask
            case UNAuthorizationStatusAuthorized:
            {
                // Just try and register for remote notifications
                NSLog(@"CDVCommandStatus_OK");
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }
                break;
                // We are denied User Notifications
            case UNAuthorizationStatusDenied:
            {
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:true];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
            }
                break;
            case UNAuthorizationStatusProvisional: {
                
                break;
            }
        }
        
    }];
}

-(void)openSetting:(CDVInvokedUrlCommand*)command {
    BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
