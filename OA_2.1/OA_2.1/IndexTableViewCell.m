//
//  IndexTableViewCell.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "IndexTableViewCell.h"

@implementation IndexTableViewCell

+ (UIFont *)titleFont {
    return [UIFont systemFontOfSize:17];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initUI:(id)picture w:(float)w{
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.contentView.layer setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.93 alpha:1].CGColor];
    
    [self.borderView.layer setBorderColor:[UIColor colorWithRed:0.84 green:0.82 blue:0.84 alpha:1].CGColor];
    [self.borderView.layer setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1].CGColor];
    [self.borderView.layer setBorderWidth:1.0f];
    [self.borderView.layer setCornerRadius:5];
    [self.borderView setClipsToBounds:YES];

    

    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.pictureImageView];
    [self.pictureImageView setImageURL:[NSURL URLWithString:[picture objectForKey:@"url"]]];
    [self.pictureImageView setContentMode:UIViewContentModeScaleToFill];
    
    [self.titleLabel setAdjustsFontSizeToFitWidth:NO];
    [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.titleLabel setText:[picture objectForKey:@"title"]];
    [self.titleLabel setFont:[IndexTableViewCell titleFont]];
    
//    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.avatarImageView];
//    [self.avatarImageView setImageURL:[NSURL URLWithString:@"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xpa1/v/t1.0-9/11048657_1080777421935599_5837445915403701082_n.jpg?oh=2443543609875efd1cfbeb180ce4eb6f&oe=5632E7AC&__gda__=1442328774_767b4bf2cebffa46d3e54485004b535b"]];
//    [self.avatarImageView.layer setCornerRadius:35];
//    [self.avatarImageView setClipsToBounds:YES];
    
//    [self.pictureImageView]
    
//    cell.textLabel.text = @"asd";
    
//    CGSize maxSize = CGSizeMake(self.titleLabel.frame.size.width, MAXFLOAT);
//    
//    CGRect labelRect = [self.titleLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
    
//    NSLog(@"size %@", self.titleLabel.font);
//    float widthIs = [@"d" boundingRectWithSize:self.titleLabel.frame.size
//                                                       options:NSStringDrawingUsesLineFragmentOrigin
//                                                    attributes:@{ NSFontAttributeName:self.titleLabel.font }
//                                                       context:nil].size.height;
////        [@"" boundingRectWithSize:self.titleLabel.frame.size options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
//    NSLog(@"the width of yourLabel is %f", widthIs);

    // UILabel *myLabel;
    
//    CGSize labelSize = [@"das" sizeWithFont:self.titleLabel.font
//                                constrainedToSize:self.titleLabel.frame.size
//                                    lineBreakMode:NSLineBreakByWordWrapping];
//    
//    CGFloat labelHeight = labelSize.height;
//    
//    
//    int lines = [self.titleLabel.text sizeWithFont:self.titleLabel.font
//                         constrainedToSize:self.titleLabel.frame.size
//                             lineBreakMode:NSLineBreakByWordWrapping].height/16;
//    CGSize labelHeight = [self calwordH:self.titleLabel.text canputwidth:w - 132];
//    NSLog(@"%f", labelHeight.height);
//    self.titleLabel
    
//    NSString *fontName = self.titleLabel.font.fontName;
//    CGFloat fontSize = self.titleLabel.font.pointSize;
//    
//    NSLog(@"%@ , %f", fontName, fontSize);
//    NSLog(@"%f", w - 112);
//    ;
    
    
//    
//    [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17]];
//    NSLog(@"%@", [self.titleLabel font]);
    
//    CGSize maxSize = CGSizeMake(self.titleLabel.frame.size.width, MAXFLOAT);
    //
    //    CGSize x = [string boundingRectWithSize:maxSize
    //                                    options:NSStringDrawingUsesLineFragmentOrigin
    //                                 attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:17] }
    //                                    context:nil];
    
}


//- (int)lineCountForLabel:(UILabel *)label {
//    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
//    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
//    
//    return ceil(size.height / label.font.lineHeight);
//}
@end
