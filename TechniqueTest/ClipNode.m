//
//  ClipNode.m
//  TechniqueTest
//
//  Created by Alok Rao on 2/23/15.
//  Copyright (c) 2015 Venator. All rights reserved.
//

#import "ClipNode.h"
#import <GLKit/GLKit.h>

@implementation ClipNode

- (id)init {
    if (self = [super init]) {
        self.rendererDelegate = self;
    }
    return self;
}

- (void)renderNode:(SCNNode *)node renderer:(SCNRenderer *)renderer arguments:(NSDictionary *)arguments {
    //glClearColor(1.0, 1.0, 0.0, 1.0);
    
    
}

@end
