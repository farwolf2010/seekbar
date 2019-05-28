//
//  WXSeekBar.m
//  AFNetworking
//
//  Created by 郑江荣 on 2019/4/17.
//

#import "WXSeekBar.h"
#import "farwolf.h"
WX_PlUGIN_EXPORT_COMPONENT(seekbar, WXSeekBar)
@interface WXSeekBar ()

@end

@implementation WXSeekBar

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        
        if(attributes[@"color"])
        {
            self.color = [WXConvert NSString:attributes[@"color"]]?:@"#000000";
        }
        if(attributes[@"progress"])
        {
            _progress =[WXConvert CGFloat:attributes[@"progress"]]?:0;
        }
        if(attributes[@"min"])
        {
            _min =[WXConvert CGFloat:attributes[@"min"]]?:0;
        }
        if(attributes[@"max"])
        {
            _max =[WXConvert CGFloat:attributes[@"max"]]?:0;
        }
        
        
    }
    
    //     UIFont *font = [WXUtility fontWithSize:_fontSize textWeight:_fontWeight textStyle:_fontStyle fontFamily:_fontFamily scaleFactor:self.weexInstance.pixelScaleFactor useCoreText:[self useCoreText]];
    return self;
}

-(void)viewDidLoad{
    [self update];
        UISlider *sl= self.view;
   
 
//    [sl setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    [sl addTarget:self action:@selector(sliderProgressChange:) forControlEvents:UIControlEventValueChanged];
    [sl addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [sl addTarget:self action:@selector(sliderTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)sliderProgressChange:(UIGestureRecognizer*)e{
      UISlider *sl= self.view;
    [self fireEvent:@"change" params:@{@"value":@(sl.value)}];
}
-(void)sliderTouchDown:(UIGestureRecognizer*)e{
    UISlider *sl= self.view;
    [self fireEvent:@"start" params:@{@"value":@(sl.value)}];
}
-(void)sliderTouchUpInSide:(UIGestureRecognizer*)e{
//    UISlider *sl= self.view;
    dispatch_async(dispatch_get_main_queue(), ^{
         [self fireEvent:@"stop" params:@{}];
    });
   
}

-(void)update{
    UISlider *sl= self.view;
    sl.minimumValue=self.min;
    sl.maximumValue=self.max;
    sl.value=self.progress;
    sl.tintColor=[self.color toColor];
     [sl setThumbTintColor:[self.color toColor]];
    UIImage *img=[[UIImage imageNamed:@"slid"] toColor:self.color];
    [sl setThumbImage:img forState:UIControlStateNormal];
    [sl setThumbImage:img forState:UIControlStateHighlighted];

}

- (UISlider *)loadView
{
    UISlider *kl;
  
    return [UISlider new];
}

-(void)updateAttributes:(NSDictionary *)attributes{
    
    if(attributes[@"color"])
    {
        self.color = [WXConvert NSString:attributes[@"color"]]?:@"#000000";
       
    }
    if(attributes[@"progress"])
    {
        _progress =[WXConvert CGFloat:attributes[@"progress"]]?:0;
    }
    if(attributes[@"min"])
    {
        _min =[WXConvert CGFloat:attributes[@"min"]]?:0;
    }
    if(attributes[@"max"])
    {
        _max =[WXConvert CGFloat:attributes[@"max"]]?:0;
    }
    if(attributes.allKeys.count>0){
        [self update];
    }
}

@end
