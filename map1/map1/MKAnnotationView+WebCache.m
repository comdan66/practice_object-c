//
//  MKAnnotationView+WebCache.m
//  SDWebImage
//
//  Created by Olivier Poitrey on 14/03/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "MKAnnotationView+WebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"

static char imageURLKey;

@implementation MKAnnotationView (WebCache)

- (NSURL *)sd_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)sd_setImageWithURL:(NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 completed:completedBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 completed:completedBlock];
}

//- (UIImage*)imageWithBorderFromImage:(UIImage*)source;
//{
////    return source;
//    
//    
//    const CGFloat margin = 10.0f;
//    CGSize size = CGSizeMake([source size].width + 2 * margin, [source size].height + 2 * margin);
//
//    UIGraphicsBeginImageContext(size);
//
//    [[UIColor whiteColor] setFill];
//    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:20] fill];
//    
//    
//    
////    size = CGSizeMake([source size].width + 2 * margin, [source size].height + 2 * margin);
//    
////    UIGraphicsBeginImageContext(size);
//
//    [[UIColor redColor] setFill];
//    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width + 2 * margin - 10, size.height + 2 * margin - 10) cornerRadius:20] fill];
//    
//    
//    
//    
//
//    CGRect rect = CGRectMake(margin, margin, size.width - 2 * margin, size.height - 2 * margin);
//    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
//    
////    CGContextRef context = UIGraphicsGetCurrentContext();
//
////    CGFloat roundRadius = 5;
////    CGFloat minx = 0, midx = CGRectGetMidX(rect), maxx = [source size].width + 2 * margin;
////    CGFloat miny = 0, midy = CGRectGetMidY(rect), maxy = [source size].height + 2 * margin;
////    
////    NSLog(@"%f %f %f\n%f %f %f", minx, midx, maxx, miny, midy, maxy);
////    
////    
////    
////    
////    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1] CGColor]);
////    CGContextMoveToPoint(context, minx, midy);
////    CGContextAddArcToPoint(context, minx, miny, midx, miny, roundRadius);
////    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, roundRadius);
////    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, roundRadius);
////    CGContextAddArcToPoint(context, minx, maxy, minx, midy, roundRadius);
////    CGContextClosePath(context);
////    CGContextDrawPath(context, kCGPathStroke);
////
//    
//    //
////        CGContextRef context = UIGraphicsGetCurrentContext();
////        CGRect xxx = CGRectMake(0, 0, size.width, size.height);
////        CGContextStrokeRect(context, xxx);
////    
//        UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return testImg;
//    
////    UIImage *image = source;
//    
////    // Begin a new image that will be the new image with the rounded corners
////    // (here with the size of an UIImageView)
////    UIGraphicsBeginImageContextWithOptions(source.size, NO, source.scale);
////    
////    const CGRect RECT = CGRectMake(0, 0, source.size.width, source.size.height);
////    [[UIBezierPath bezierPathWithRoundedRect:RECT cornerRadius:5.0f] addClip];
////    [source drawInRect:RECT];
////    
////    // Get the image, here setting the UIImageView image
////    //imageView.image
////    UIImage* imageNew = UIGraphicsGetImageFromCurrentImageContext();
////    
////    // Lets forget about that we were drawing
////    UIGraphicsEndImageContext();
////    
////    return imageNew;
//    
//    
//    
////    const CGFloat margin = 10.0f;
////    CGSize size = CGSizeMake([source size].width + 2 * margin, [source size].height + 2 * margin);
//    
////    UIGraphicsBeginImageContext(size);
////
////    [[UIColor whiteColor] setFill];
////    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
//
////    
////    const CGFloat margin = 10.0f;
////    CGSize size = [source size];
////    UIGraphicsBeginImageContext(size);
////
////    
////    CGRect rect = CGRectMake(margin, margin, size.width - 2 * margin, size.height - 2 * margin);
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    
////    CGFloat roundRadius = 12.0;
////    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
////    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
////    
////    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1] CGColor]);
////    CGContextMoveToPoint(context, minx, midy);
////    CGContextAddArcToPoint(context, minx, miny, midx, miny, roundRadius);
////    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, roundRadius);
////    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, roundRadius);
////    CGContextAddArcToPoint(context, minx, maxy, minx, midy, roundRadius);
////    CGContextClosePath(context);
////    CGContextDrawPath(context, kCGPathStroke);
////    
////    
////    
////    
////    
////    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
////
//////
//////    CGContextRef context = UIGraphicsGetCurrentContext();
//////    CGRect xxx = CGRectMake(0, 0, size.width, size.height);
//////    CGContextStrokeRect(context, xxx);
////
////    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
////    return testImg;
//    
//    
////    CGSize size = [source size];
////    UIGraphicsBeginImageContext(size);
////    CGRect rect = CGRectMake(0, 0, size.width, size.height);
////    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
////    
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
////    CGContextStrokeRect(context, rect);
////
////    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
////    return testImg;
//    
////    const CGFloat margin = 10.0f;
////    CGSize size = CGSizeMake([source size].width + 2 * margin, [source size].height + 2 * margin);
////    UIGraphicsBeginImageContext(size);
////    
////    [[UIColor whiteColor] setFill];
////    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
////    
////    
////    
////
////    
////
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    
////    CGFloat roundRadius = 12.0;
////    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
////    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
////
////
////    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1] CGColor]);
////    CGContextMoveToPoint(context, minx, midy);
////    CGContextAddArcToPoint(context, minx, miny, midx, miny, roundRadius);
////    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, roundRadius);
////    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, roundRadius);
////    CGContextAddArcToPoint(context, minx, maxy, minx, midy, roundRadius);
////    CGContextClosePath(context);
////    CGContextDrawPath(context, kCGPathStroke);
////    
//////    CGContextRestoreGState(context);
//////
////
////    
////    
////    
//////    CGContextRef context = UIGraphicsGetCurrentContext();
//////    CGRect xxx = CGRectMake(0, 0, size.width, size.height);
//////    CGContextStrokeRect(context, xxx);
////
////    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
////    return testImg;
//}
//-(void) addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight){
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) {
//        CGContextAddRect(context, rect);
//        return;
//    }
//    CGContextSaveGState(context);
//    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM (context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth (rect) / ovalWidth;
//    fh = CGRectGetHeight (rect) / ovalHeight;
//    CGContextMoveToPoint(context, fw, fh/2);
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}

- (UIImage *)generatePhotoStackWithImage:(UIImage *)image {
    CGFloat boderWidth = 10;
    CGSize newSize = CGSizeMake(image.size.width + 70, image.size.height + 70);
    CGRect rect = CGRectMake(25, 25, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale); {
        CGContextRef context = UIGraphicsGetCurrentContext();
        //Shadow
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f].CGColor);
        
        CGContextBeginTransparencyLayer (context, NULL);
        //Draw
        
        [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:2.5f] addClip];
        [image drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextStrokeRectWithWidth(context, rect, 10);
        CGContextEndTransparencyLayer(context);
        
//            [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:20] fill];
    }
    UIImage *result =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_cancelCurrentImageLoad];

    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = placeholder;

    if (url) {
        __weak __typeof(self)wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong MKAnnotationView *sself = wself;
                if (!sself) return;
                if (image) {
                    sself.image = image;
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"MKAnnotationViewImage"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)sd_cancelCurrentImageLoad {
    [self sd_cancelImageLoadOperationWithKey:@"MKAnnotationViewImage"];
}

@end


@implementation MKAnnotationView (WebCacheDeprecated)

- (NSURL *)imageURL {
    return [self sd_imageURL];
}

- (void)setImageWithURL:(NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)cancelCurrentImageLoad {
    [self sd_cancelCurrentImageLoad];
}

@end
