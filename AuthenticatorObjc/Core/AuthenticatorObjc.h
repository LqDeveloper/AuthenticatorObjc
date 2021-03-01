//
//  AuthenticatorObjc.h
//  AuthenticatorObjc
//
//  Created by liquan on 2021/3/1.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
NS_ASSUME_NONNULL_BEGIN

@interface AuthenticatorObjc : NSObject
+(instancetype)shared;

/// 允许的重复使用的时间
@property(nonatomic,assign)NSTimeInterval allowableReuseDuration;

/// 检查当前是否可以在设备上执行生物特征认证。
@property(nonatomic,assign,readonly)BOOL canAuthenticate;

/// 判断当前设置是否具有FaceID(注意：这不会检查设备是否可以执行生物特征认证)
@property(nonatomic,assign,readonly)BOOL isFaceIdDevice;

/// 是否支持Face
@property(nonatomic,assign,readonly)BOOL faceIDAvailable;

/// 是否支持TouchId
@property(nonatomic,assign,readonly)BOOL touchIDAvailable;


/// 验证
/// @param policy LAPolicy
/// @param context LAContext
/// @param reason 请求验证的原因
/// @param completion 完成的回调
-(void)evaluatePolicy:(LAPolicy)policy context:(LAContext *)context reason:(NSString *)reason completion:(void(^)(BOOL success, NSError * __nullable error))completion;

/// FaceID,TouchID验证
/// @param reason 请求验证的原因
/// @param fallback 当验证出现失败时，弹出出现的后备的验证方式(如输入密码)。 如果设置为空字符串，该按钮将被隐藏。当此属性保留为零时，将使用默认标题“输入密码”。
/// @param cancel 取消标题
/// @param completion 完成回调
-(void)authenticateWithBioMetrics:(NSString *)reason fallbackTitle:(NSString *)fallback cancelTitle:(NSString *)cancel completion:(void(^)(BOOL success, NSError * __nullable error))completion;


/// 设备密码验证(后备验证方式)
/// @param reason 请求验证的原因
/// @param cancel 取消标题
/// @param completion 完成回调
-(void)authenticateWithPasscode:(NSString *)reason cancelTitle:(NSString *)cancel completion:(void(^)(BOOL success, NSError * __nullable error))completion;
@end

NS_ASSUME_NONNULL_END
