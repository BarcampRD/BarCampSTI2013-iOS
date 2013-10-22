//
//  UITableViewController+Theme.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "UITableViewController+Theme.h"

@implementation UITableViewController (Theme)
-(void)loadNavBarLogo{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_logo_small"]];
    [iv sizeToFit];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.autoresizesSubviews = YES;
    self.navigationItem.titleView = iv;
}

@end
