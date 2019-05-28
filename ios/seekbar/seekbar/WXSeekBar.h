//
//  WXSeekBar.h
//  AFNetworking
//
//  Created by 郑江荣 on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXResourceLoader.h>
#import <WeexPluginLoader/WeexPluginLoader.h>
 

@interface WXSeekBar : WXComponent
@property (nonatomic,strong)NSString *color;
@property (nonatomic)float progress;
@property (nonatomic)float min;
@property (nonatomic)float max;
@end


