//
//  AuthenticatorObjc.m
//  AuthenticatorObjc
//
//  Created by liquan on 2021/3/1.
//

#import "AuthenticatorObjc.h"

@interface AuthenticatorObjc()
@property(nonatomic,strong)LAContext *context;
@end
@implementation AuthenticatorObjc
+(instancetype)shared{
    static AuthenticatorObjc *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AuthenticatorObjc alloc]init];
    });
    return instance;
}

- (LAContext *)context{
    if (!_context) {
        _context = [[LAContext alloc]init];
    }
    return _context;
}

- (void)setAllowableReuseDuration:(NSTimeInterval)allowableReuseDuration{
    _allowableReuseDuration = allowableReuseDuration;
    self.context.touchIDAuthenticationAllowableReuseDuration = allowableReuseDuration;
}

- (BOOL)canAuthenticate{
    BOOL isAvailable = false;
    NSError *error;
    if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        isAvailable = (error == nil) ? YES : NO;
    }
    return isAvailable;
}

- (BOOL)isFaceIdDevice{
    [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    if (@available(iOS 11.0, *)) {
        return  self.context.biometryType == LABiometryTypeFaceID;
    }
    return false;
}

- (BOOL)faceIDAvailable{
    NSError *error;
    BOOL canEvaluate = [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (@available(iOS 11.0, *)) {
        return  self.context.biometryType == LABiometryTypeFaceID && canEvaluate;
    }
    return canEvaluate;
}

- (BOOL)touchIDAvailable{
    NSError *error;
    BOOL canEvaluate = [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (@available(iOS 11.0, *)) {
        return  self.context.biometryType == LABiometryTypeTouchID && canEvaluate;
    }
    return canEvaluate;
}


-(void)authenticateWithBioMetrics:(NSString *)reason fallbackTitle:(NSString *)fallback cancelTitle:(NSString *)cancel completion:(void(^)(BOOL success, NSError * __nullable error))completion{
    self.context.localizedFallbackTitle = fallback;
    if (@available(iOS 10.0, *)) {
        self.context.localizedCancelTitle = cancel;
    }
    [self evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics context:self.context reason:reason completion:completion];
}

-(void)authenticateWithPasscode:(NSString *)reason cancelTitle:(NSString *)cancel completion:(void(^)(BOOL success, NSError * __nullable error))completion{
    if (@available(iOS 10.0, *)) {
        self.context.localizedCancelTitle = cancel;
    }
    
    [self evaluatePolicy:LAPolicyDeviceOwnerAuthentication context:self.context reason:reason completion:completion];
}

-(void)evaluatePolicy:(LAPolicy)policy context:(LAContext *)context reason:(NSString *)reason completion:(void(^)(BOOL success, NSError * __nullable error))completion{
    [context evaluatePolicy:policy localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
        if (completion == nil) {return;}
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(success,error);
        });
    }];
}

@end
