//
//  AppleLogoView.m
//  AppleLogo
//
//  References:
//      http://preserve.mactech.com/articles/mactech/Vol.21/21.06/SaveOurScreens/index.html
//      http://preserve.mactech.com/articles/mactech/Vol.21/21.07/SaveOurScreens102/index.html
//      http://www.cocoadevcentral.com/articles/000088.php
//

#import "AppleLogoView.h"

@implementation AppleLogoView

static NSString * const MyModuleName = @"com.demux.AppleLogo";
static const float kLogoScale = 0.2;  // fraction of the screen to occupy

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:10.0];
    }
    mBundle = [NSBundle bundleWithIdentifier:MyModuleName];
    //image = [[NSImage alloc] initWithContentsOfFile:[mBundle pathForResource:@"AppleLogo" ofType:@"png"]];
    return self;
}

- (void)startAnimation
{
    [super startAnimation];

}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)viewDidMoveToWindow {
   mDrawBackground = YES;
}

- (BOOL)isOpaque {
   // this keeps Cocoa from unneccessarily redrawing our superview
   return YES;
}

- (void)drawRect:(NSRect)rect
{
    //[super drawRect:rect];  // default black background
    
    NSRect viewBounds = [self bounds];
    
    //[[NSColor colorWithDeviceRed: 0.75 green: 0.70 blue: 0.58 alpha: 1.0] set];  // beige
    [[NSColor colorWithDeviceRed: 0.0 green: 0.0 blue: 0.0 alpha: 1.0] set];
    [NSBezierPath fillRect: viewBounds];
    
    if ( mDrawBackground ) {
       //   when view is installed in a window for the first time, only draw background
       
       mDrawBackground = NO;
        return;
    }

    NSImage *image = [self getAppleLogo];
    
    // scale the image
    NSSize newSize;
    float scaleScreenRef = MIN(viewBounds.size.width, viewBounds.size.height);
    float scaleImageRef = MAX(logo.size.width, logo.size.height);
    
    float targetSize = kLogoScale * scaleScreenRef;
    float scaleFactor = targetSize / scaleImageRef;
    newSize.width = image.size.width * scaleFactor;
    newSize.height = image.size.height * scaleFactor;
    
    [image setSize:newSize];
    
    NSPoint imagePoint = SSRandomPointForSizeWithinRect(newSize, viewBounds);

    [image drawAtPoint:imagePoint fromRect:NSZeroRect operation:NSCompositingOperationSourceAtop fraction:1.0];
    
    //NSAttributedString * testString = [[NSAttributedString alloc] initWithString:@"Testing"];
    //[testString drawAtPoint:imagePoint];
}

- (void)animateOneFrame
{
    [self setNeedsDisplay: true];  // causes drawing to happen in drawRect
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (NSImage*) getAppleLogo {
   if ( logo == nil ) {
      NSBundle* saverBundle =
            [NSBundle bundleForClass: [self class]];
      NSString* imagePath = [saverBundle
                             pathForResource:@"apple-logo" ofType:@"png"];
      logo = [[NSImage alloc]
            initWithContentsOfFile: imagePath];
   }
   return logo;
}

@end
