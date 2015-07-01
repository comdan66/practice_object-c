//
//  IndexTableViewCell.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "IndexTableViewCell.h"

@implementation IndexTableViewCell


+ (UIFont *) nameLabelFont {
    return [UIFont systemFontOfSize:16.0f];
}
+ (UIFont *) createdLabelFont {
    return [UIFont systemFontOfSize:11.0f];
}
+ (UIFont *) descriptionLabelFont {
    return [UIFont systemFontOfSize:12.0f];
}
+ (CGFloat) descriptionLabelLineSpacing {
    return 2.f;
}
+ (CGFloat) descriptionLabelSpacing {
    return 0.5f;
}

+ (UIFont *) likeButtonFont {
    return [UIFont systemFontOfSize:13.0f];
}
+ (UIFont *) commentButtonFont {
    return [UIFont systemFontOfSize:13.0f];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IndexTableViewCell *)initBaseData {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView.layer setBackgroundColor:[UIColor colorWithRed:0.9 green:0.88 blue:0.87 alpha:1].CGColor];
    
    [self.borderView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor];
    [self.borderView.layer setBorderColor:[UIColor colorWithRed:0.79 green:0.74 blue:0.72 alpha:1.0].CGColor];
    [self.borderView.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.borderView.layer setCornerRadius:5];
    [self.borderView setClipsToBounds:YES];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.pictureImageView];
    [self.pictureImageView setContentMode:UIViewContentModeScaleToFill];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.avatarImageView];
    [self.avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.avatarImageView.layer setCornerRadius:30];
    [self.avatarImageView.layer setBorderColor:[UIColor colorWithRed:0.90 green:0.87 blue:0.87 alpha:1.0].CGColor];
    [self.avatarImageView.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.avatarImageView setClipsToBounds:YES];
    
    [self.likeButton setImage: [UIImage imageNamed:@"LikeIcon"] forState:UIControlStateNormal];
    [self.likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 3.0, 1.0, 0.0)];
    [self.likeButton setTintColor:[UIColor colorWithRed:0.92 green:0.28 blue:0.29 alpha:1]];
    [self.likeButton setTitle:@"+11 最愛" forState:UIControlStateNormal];
    [self.likeButton setTitleColor:[UIColor colorWithRed:0.92 green:0.28 blue:0.29 alpha:1] forState:UIControlStateNormal];
    [self.likeButton.titleLabel setNumberOfLines:1];
    [self.likeButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.likeButton.titleLabel setLineBreakMode:NSLineBreakByClipping];
    [self.likeButton.titleLabel setFont:[IndexTableViewCell likeButtonFont]];
    
    [self.commentButton setImage: [UIImage imageNamed:@"CommentIcon"] forState:UIControlStateNormal];
    [self.commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 3.0, 1.0, 0.0)];
    [self.commentButton setTintColor:[UIColor colorWithRed:0.92 green:0.28 blue:0.29 alpha:1]];
    [self.commentButton setTitle:@"12 則留言" forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor colorWithRed:0.92 green:0.28 blue:0.29 alpha:1] forState:UIControlStateNormal];
    [self.commentButton.titleLabel setNumberOfLines:1];
    [self.commentButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.commentButton.titleLabel setLineBreakMode:NSLineBreakByClipping];
    [self.commentButton.titleLabel setFont:[IndexTableViewCell commentButtonFont]];
    
    [self.nameLabel setFont:[IndexTableViewCell nameLabelFont]];
    [self.nameLabel setTextColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    
    [self.createdLabel setFont:[IndexTableViewCell createdLabelFont]];
    [self.createdLabel setTextColor:[UIColor colorWithRed:0.9 green:0.3 blue:0.3 alpha:1]];
    
    [self.descriptionLabel setAdjustsFontSizeToFitWidth:NO];
    [self.descriptionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.descriptionLabel setFont:[IndexTableViewCell descriptionLabelFont]];
    [self.descriptionLabel setTextColor:[UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:[IndexTableViewCell descriptionLabelLineSpacing]];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.descriptionLabel.text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.descriptionLabel.text length])];
    [attributedString addAttribute:NSKernAttributeName
                             value:@([IndexTableViewCell descriptionLabelSpacing])
                             range:NSMakeRange(0, [self.descriptionLabel.text length])];
    
    [self.descriptionLabel setAttributedText:attributedString];
    
    return self;
}
- (void) clean {
    [self.pictureImageView setImage:nil];
    [self.avatarImageView setImage:nil];
    
}
- (IndexTableViewCell *)initUI:(id)picture w:(float)w{

    [self.pictureImageView setImageURL:[NSURL URLWithString:[picture objectForKey:@"url"]]];
    if ([picture objectForKey:@"color"] != nil) {
        id color = [picture objectForKey:@"color"];
        [self.pictureImageView setBackgroundColor:[UIColor colorWithRed:[[color objectForKey:@"red"] doubleValue] / 255.0f
                                                                  green:[[color objectForKey:@"green"] doubleValue] / 255.0f
                                                                   blue:[[color objectForKey:@"blue"] doubleValue] / 255.0f alpha:0.85f]];
    }

    [self.avatarImageView setImageURL:[NSURL URLWithString:[[picture objectForKey:@"user"] objectForKey:@"avatar"]]];
    if (([picture objectForKey:@"user"] != nil) && ([[picture objectForKey:@"user"] objectForKey:@"color"] != nil)) {
        id color = [[picture objectForKey:@"user"] objectForKey:@"color"];
        [self.avatarImageView setBackgroundColor:[UIColor colorWithRed:[[color objectForKey:@"red"] doubleValue] / 255.0f
                                                                 green:[[color objectForKey:@"green"] doubleValue] / 255.0f
                                                                  blue:[[color objectForKey:@"blue"] doubleValue] / 255.0f alpha:1.0f]];
    }
    
    
    
    [self.nameLabel setText:[[picture objectForKey:@"user"] objectForKey:@"name"]];
    
    [self.createdLabel setText:[picture objectForKey:@"created_at"]];
    
    [self.horizontalRuleLabel1 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:0.40]];
    [self.horizontalRuleLabel2 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:0.40]];
    
    
    [self.descriptionLabel setText:[picture objectForKey:@"description"]];
    
    
    if ([[picture objectForKey:@"description"] isEqualToString:@""] || ([[picture objectForKey:@"description"] length] <= 0)) {
        [self.descriptionLabel setHidden:YES];
        [self.horizontalRuleLabel2 setHidden:YES];
        [self.horizontalRuleDescription setConstant:0.0f];
        [self.descriptionHorizontalRule setConstant:-0.5f];
        [self updateConstraints];
    }
    return self;
}


//- (int)lineCountForLabel:(UILabel *)label {
//    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
//    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
//    
//    return ceil(size.height / label.font.lineHeight);
//}
@end
