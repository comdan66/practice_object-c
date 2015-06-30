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

- (UIImage*)imageWithBorderFromImage:(UIImage*)source;
{
    
    const CGFloat margin = 10.0f;
    CGSize size = CGSizeMake([source size].width + 2 * margin, [source size].height + 2 * margin);
    UIGraphicsBeginImageContext(size);

    [[UIColor whiteColor] setFill];
    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
    
        CGRect rect = CGRectMake(margin, margin, size.width - 2 * margin, size.height - 2 * margin);
        [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect xxx = CGRectMake(0, 0, size.width, size.height);
        CGContextStrokeRect(context, xxx);
    
        UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return testImg;
    
    
//    CGSize size = [source size];
//    UIGraphicsBeginImageContext(size);
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
//    CGContextStrokeRect(context, rect);
//
//    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return testImg;
    
//    const CGFloat margin = 10.0f;
//    CGSize size = CGSizeMake([source size].width + 2 * margin, [source size].height + 2 * margin);
//    UIGraphicsBeginImageContext(size);
//    
//    [[UIColor whiteColor] setFill];
//    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
//    
//    
//    
//
//    
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGFloat roundRadius = 12.0;
//    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
//    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
//
//
//    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1] CGColor]);
//    CGContextMoveToPoint(context, minx, midy);
//    CGContextAddArcToPoint(context, minx, miny, midx, miny, roundRadius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, roundRadius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, roundRadius);
//    CGContextAddArcToPoint(context, minx, maxy, minx, midy, roundRadius);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathStroke);
//    
////    CGContextRestoreGState(context);
////
//
//    
//    
//    
////    CGContextRef context = UIGraphicsGetCurrentContext();
////    CGRect xxx = CGRectMake(0, 0, size.width, size.height);
////    CGContextStrokeRect(context, xxx);
//
//    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return testImg;
}
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
                    sself.image = [self imageWithBorderFromImage:image];
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
