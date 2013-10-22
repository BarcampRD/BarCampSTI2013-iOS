/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "objc/runtime.h"

static char operationKey;

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url highLightImageURL:nil placeholderImage:nil placeholderHighlightImage:nil options:0 progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url highLightImageURL:nil placeholderImage:placeholder placeholderHighlightImage:nil options:0 progress:nil completed:nil];
}

-(void)setImageWithURL:(NSURL *)url highLightImageURL:(NSURL *)hurl placeholderImage:(UIImage *)placeholder placeholderHighlightImage:(UIImage *) hplaceholder {
    [self setImageWithURL:url highLightImageURL:hurl placeholderImage:placeholder placeholderHighlightImage:nil options:0 progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self setImageWithURL:url highLightImageURL:nil placeholderImage:placeholder placeholderHighlightImage:nil options:options progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url highLightImageURL:nil placeholderImage:nil placeholderHighlightImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url highLightImageURL:nil placeholderImage:placeholder placeholderHighlightImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url highLightImageURL:nil placeholderImage:placeholder placeholderHighlightImage:nil options:options progress:nil completed:completedBlock];
}

- (void)setImageWithURL:(NSURL *)url highLightImageURL:(NSURL *) hurl placeholderImage:(UIImage *)placeholder placeholderHighlightImage:(UIImage *)hplaceholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];

    self.image = placeholder;
    self.highlightedImage = hplaceholder;
    if (url)
    {
        __weak UIImageView *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
            if (!wself) return;
            void (^block)(void) = ^
            {
                __strong UIImageView *sself = wself;
                if (!sself) return;
                if (image)
                {
                    sself.image = image;
                    [sself setNeedsLayout];
                }
                if (completedBlock && finished)
                {
                    completedBlock(image, error, cacheType);
                }
            };
            if ([NSThread isMainThread])
            {
                block();
            }
            else
            {
                dispatch_sync(dispatch_get_main_queue(), block);
            }
        }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (hurl)
    {
        __weak UIImageView *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:hurl options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
                                             {
                                                 if (!wself) return;
                                                 void (^block)(void) = ^
                                                 {
                                                     __strong UIImageView *sself = wself;
                                                     if (!sself) return;
                                                     if (image)
                                                     {
                                                         sself.highlightedImage = image;
                                                         [sself setNeedsLayout];
                                                     }
                                                     if (completedBlock && finished)
                                                     {
                                                         completedBlock(image, error, cacheType);
                                                     }
                                                 };
                                                 if ([NSThread isMainThread])
                                                 {
                                                     block();
                                                 }
                                                 else
                                                 {
                                                     dispatch_sync(dispatch_get_main_queue(), block);
                                                 }
                                             }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    
    if([self.superview.superview isKindOfClass:[UITableViewCell class]]){
        [((UITableViewCell *)self.superview.superview) updateConstraints];
    }
}

- (void)cancelCurrentImageLoad
{
    // Cancel in progress downloader from queue
    id<SDWebImageOperation> operation = objc_getAssociatedObject(self, &operationKey);
    if (operation)
    {
        [operation cancel];
        objc_setAssociatedObject(self, &operationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
