//
//  OpenCVWrapper.m
//  BlurTestSwift
//
//  Created by Zeeshan Haider on 20/06/2017.
//  Copyright © 2017 <#Project Team#>. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/objdetect/objdetect.hpp>
#import <opencv2/opencv.hpp>
using namespace std;

@implementation OpenCVWrapper

+ (cv::Mat)convertUIImageToCVMat:(UIImage *)image {
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}
short GetSharpness(char* data, unsigned int width, unsigned int height)
{
    // assumes that your image is already in planner yuv or 8 bit greyscale
    IplImage* in = cvCreateImage(cvSize(width,height),IPL_DEPTH_8U,1);
    IplImage* out = cvCreateImage(cvSize(width,height),IPL_DEPTH_16S,1);
    memcpy(in->imageData,data,width*height);
    
    // aperture size of 1 corresponds to the correct matrix
    cvLaplace(in, out, 1);
    
    short maxLap = -32767;
    short* imgData = (short*)out->imageData;
    for(int i =0;i<(out->imageSize/2);i++)
    {
        if(imgData[i] > maxLap) maxLap = imgData[i];
    }
    
    cvReleaseImage(&in);
    cvReleaseImage(&out);
    return maxLap;
}
    
+ (BOOL) isImageBlurry:(UIImage *) image {
    // converting UIImage to OpenCV format - Mat
    cv::Mat matImage = [OpenCVWrapper convertUIImageToCVMat:image];
    cv::Mat matImageGrey;
    // converting image's color space (RGB) to grayscale
    cv::cvtColor(matImage, matImageGrey, CV_BGR2GRAY);
    
    cv::Mat dst2 = [OpenCVWrapper convertUIImageToCVMat:image];
    cv::Mat laplacianImage;
    dst2.convertTo(laplacianImage, CV_8UC1);
    
    // applying Laplacian operator to the image
    cv::Laplacian(matImageGrey, laplacianImage, CV_8U);
    cv::Mat laplacianImage8bit;
    laplacianImage.convertTo(laplacianImage8bit, CV_8UC1);
    
    unsigned char *pixels = laplacianImage8bit.data;
    
    // 16777216 = 256*256*256
    int maxLap = -16777216;
    for (int i = 0; i < ( laplacianImage8bit.elemSize()*laplacianImage8bit.total()); i++) {
        if (pixels[i] > maxLap) {
            maxLap = pixels[i];
        }
    }
    // one of the main parameters here: threshold sets the sensitivity for the blur check
    // smaller number = less sensitive; default = 180
    int threshold = 150;
    
    return (maxLap <= threshold);
}
    
    
    
    @end
