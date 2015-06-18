//
//  ViewController.m
//  Cam
//
//  Created by OA Wu on 2015/6/17.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openPress:(id)sender {

    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *pop = imagePicker.popoverPresentationController;
    pop.sourceView = sender;
    pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    self.image.image = image;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
- (IBAction)buttonPress:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;

        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
- (UIImage *)fixOrientation: (UIImage *) myImage {
    
    // No-op if the orientation is already correct
    if (myImage.imageOrientation == UIImageOrientationUp) return myImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (myImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.width, myImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, myImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (myImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, myImage.size.width, myImage.size.height,
                                             CGImageGetBitsPerComponent(myImage.CGImage), 0,
                                             CGImageGetColorSpace(myImage.CGImage),
                                             CGImageGetBitmapInfo(myImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (myImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,myImage.size.height,myImage.size.width), myImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,myImage.size.width,myImage.size.height), myImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    UIImage *chosenImage = [info valueForKey:UIImagePickerControllerOriginalImage];
//    self.image.image = chosenImage;
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    UIImage *image = [self fixOrientation:[info valueForKey:UIImagePickerControllerOriginalImage]];
//    NSLog(@"%li", image.imageOrientation);
//    NSData *data = UIImageJPEGRepresentation(image, 0.5);
//    NSString *fullPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/data/xxx.jpg"];
//    [data writeToFile:fullPath atomically:NO];
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.image.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
    
    
//    
//    NSURL *url = [NSURL URLWithString:@"http://url"];
//    
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    UIImage *imageIWantToUpload = imageupload;
//    NSData *dataToUpload = UIImageJPEGRepresentation(imageIWantToUpload, 0.5);
//    
//    // Create the NSData object for the upload process
//    
//    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"iosuploads.php" parameters:nil constructingBodyWithBlock: ^(id<AFMultipartFormData> formData) {
//        NSLog(@"strimng");
//        [formData appendPartWithFileData:dataToUpload name:@"uploadedfile" fileName:@"attachment.jpg" mimeType:@"image/jpeg"];
//        NSLog(@"strimng");
//    }];
//    NSLog(@"strimng");
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
//    }];
//    [httpClient enqueueHTTPRequestOperation:operation];
    
    

//    
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSString *dir = [NSHomeDirectory() stringByAppendingString:@"/Documents/data"];
//    NSString *file = [dir stringByAppendingString:@"/mydata.png"];
//    
//    NSError *error = nil;
//    
//    // 在Documents下建立data目錄
//    BOOL success = [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
//    if (success) {
//        NSLog(@"目錄建立成功");
//    } else {
//        NSLog(@"目錄建立失敗");
//    }
//    
//    // 在data目錄下建立mydata.txt檔案
//    success = [fm createFileAtPath:file contents:nil attributes:nil];
//    if (success) {
//        NSLog(@"檔案建立成功");
//    } else {
//        NSLog(@"檔案建立失敗");
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
    
    
    
    
    
    
    
//    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    NSLog(@"%@", UIImagePickerControllerOriginalImage);
    
////    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
//
//    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
//    NSLog(@"%@", imageURL);
    //

//    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    self.image.image = image;
//    NSLog(@"H:%f, W:%f", self.image.image.size.height, self.image.image.size.width);
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
//    
//    UIImage* img = [info valueForKey:UIImagePickerControllerOriginalImage];
//    
//    ALAssetsLibrary *library = [ALAssetsLibrary new];
//    NSLog(@"--------");
//    
//    [library writeImageToSavedPhotosAlbum:[img CGImage] orientation:(ALAssetOrientation)[img imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
//        if (error) {
//            NSLog(@"error");
//            return;
//        }
//        
//        [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
//            NSLog(@"=====");
//            self.image.image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
//            NSLog(@"H:%f, W:%f", self.image.image.size.height, self.image.image.size.width);
//        } failureBlock:^(NSError *error) {
//            NSLog(@"Failed to load captured image.");
//        }];
//    }];
//    //    [library release];
//        [self dismissViewControllerAnimated:YES completion:nil];

//    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
//
//    NSLog(@"%@", [imageURL absoluteString]);
//    [self dismissViewControllerAnimated:YES completion:nil];

//    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    NSString *imageUrl = [NSString stringWithFormat:@"%@", image];
//    NSURL *url = [[NSURL alloc] initWithString:imageUrl];
//    NSLog(@"%@", url);
//    
//    UIImage *chosenImage = [info valueForKey:UIImagePickerControllerOriginalImage];
//    self.image.image = chosenImage;
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    
//    
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
////    NSData *webData = UIImagePNGRepresentation(image);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////    NSLog(@"%@", webData);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//
//    NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:image];
//        NSLog(@"%@", localFilePath);
//    [webData writeToFile:localFilePath atomically:YES];
//    NSLog(@"localFilePath.%@",localFilePath);
    
//    UIImage *image = [UIImage imageWithContentsOfFile:localFilePath];
    
    
    
}



- (IBAction)postButton:(id)sender {
//    NSFileManager *fm = [NSFileManager defaultManager];
////    NSArray *arr = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//    NSURL *url = [[NSURL alloc] initWithString:[NSHomeDirectory() stringByAppendingString:@"/Documents/data/"]];
//    
//    // includingPropertiesForKey: 表示要列出具備哪些屬性的檔案，nil表示所有屬性都要的意思
//    // option: 目前可以使用的參數是 NSDirectoryEnumerationSkipsHiddenFiles 代表不要列出隱藏檔
//    //         如果要連隱藏檔都列出，則使用 ~NSDirectoryEnumerationSkipsHiddenFiles
//    //         UNIX 的隱藏檔是以「.」開頭的檔案
//    NSArray *fileList = [fm contentsOfDirectoryAtURL:url
//                          includingPropertiesForKeys:nil
//                                             options:NSDirectoryEnumerationSkipsHiddenFiles
//                                               error:nil
//                         ];
//    
//    BOOL isDir;
//    for (NSURL *p in fileList) {
//        // NSURL 類別包含了檔案的絕對路徑（以URI的格式呈現）
//        // .lastPathComponent 則是URI中檔名的部分
//        if ([fm fileExistsAtPath:p.path isDirectory:&isDir] && isDir)
//            NSLog(@"%@ 是目錄.", p.lastPathComponent);
//        else
//            NSLog(@"%@ 是檔案.", p.lastPathComponent);
//    }
    
    
    
    
//    NSLog(@"%@", xx);
    
    
    

    NSData *imageData = UIImageJPEGRepresentation ([self fixOrientation:self.image.image ], 0.1);

    MyHttp *http = [MyHttp new];

    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:@"xxxxxx" forKey:@"title"];
    [vars setObject:imageData forKey:@"name"];

    [http postMulti:@"http://ios.ioa.tw/api/add_file" vars:vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", result);
    }];
    
//    ----------------------------------
//    MyHttp *http = [MyHttp new];
//    
//    NSMutableDictionary *vars = [NSMutableDictionary new];
//    [vars setObject:@"xxxxxx" forKey:@"title"];
//    
//    NSMutableArray *files = [NSMutableArray new];
//    NSMutableDictionary *file_parameters;
//    
//    
//    // set up first file
//    file_parameters = [NSMutableDictionary new];
//    [file_parameters setObject:@"name" forKey:@"name"];
//    [file_parameters setObject:[NSHomeDirectory() stringByAppendingString:@"/Documents/data/xxx.jpg"] forKey:@"local_filename"];
//    [file_parameters setObject:@"image/jpg" forKey:@"mime_type"];
//    [files addObject:file_parameters];
//    
//    
//    [http postMulti:@"http://ios.ioa.tw/api/add_file" vars:vars files:files completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@", result);
//        
//    }];
//    

    
    
    
    
    
    
    //    NSMutableDictionary *vars = [NSMutableDictionary new];
//    [vars setObject:@"xxxxxx" forKey:@"title"];
//    
//    NSMutableArray *files = [NSMutableArray new];
//    NSMutableDictionary *file_parameters;
//    
//    
//    // set up first file
//    file_parameters = [NSMutableDictionary new];
//    [file_parameters setObject:@"name" forKey:@"name"];
//    [file_parameters setObject:[NSHomeDirectory() stringByAppendingString:@"/Documents/data/xxx.jpg"] forKey:@"local_filename"];
//    [file_parameters setObject:@"image/jpg" forKey:@"mime_type"];
//    [files addObject:file_parameters];
//    
//    
//    [http postMulti:@"http://ios.ioa.tw/api/add_file" vars:vars files:files completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@", result);
//        
//    }];
//    
    
    
    
//    [http postURL:@"http://ios.ioa.tw/api/add_event" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSString *title = [[NSString alloc] initWithFormat:[[result objectForKey:@"status"] boolValue] ? @"新增成功！" : @"新增失敗！"];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
//            
//            UIAlertView *ok = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
//            [ok show];
//        });
//    }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
