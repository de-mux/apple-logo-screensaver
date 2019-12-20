//
//  AppleLogoView.h
//  AppleLogo
//

#import <ScreenSaver/ScreenSaver.h>

@interface AppleLogoView : ScreenSaverView
{
    BOOL mDrawBackground;
    NSBundle *mBundle;
    NSImage *logo;
}
@end
