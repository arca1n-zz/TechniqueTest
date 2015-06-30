//
//  GameViewController.h
//  TechniqueTest
//

//  Copyright (c) 2015 Venator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

@interface GameViewController : UIViewController {
    NSInteger currentTechniqueIndex;
}

@property(nonatomic, strong) NSArray *techniques;

@end
