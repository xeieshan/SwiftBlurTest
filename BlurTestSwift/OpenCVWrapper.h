//
//  OpenCVWrapper.h
//  BlurTestSwift
//
//  Created by Zeeshan Haider on 20/06/2017.
//  Copyright © 2017 <#Project Team#>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

+ (BOOL) isImageBlurry:(UIImage *) image;
@end
