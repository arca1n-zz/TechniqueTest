//
//  GameViewController.m
//  TechniqueTest
//
//  Created by Alok Rao on 2/23/15.
//  Copyright (c) 2015 Venator. All rights reserved.
//

#import "GameViewController.h"
#import "ClipNode.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // create a new scene
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.dae"];

    // create and add a camera to the scene
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    [scene.rootNode addChildNode:cameraNode];
    NSURL *url;
    url = [[NSBundle mainBundle] URLForResource:@"firstPass" withExtension:@"plist"];
    SCNTechnique *firstTechnique = [SCNTechnique techniqueWithDictionary:[NSDictionary dictionaryWithContentsOfURL:url]];
    
    //cameraNode.camera.technique = firstTechnique;
    
    
    
    // place the camera
    cameraNode.position = SCNVector3Make(0, 0, 15);
    
    // create and add a light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    // retrieve the ship node
    SCNNode *ship = [scene.rootNode childNodeWithName:@"shipMesh" recursively:YES];
    ship.categoryBitMask = 4;
    // animate the 3d object
    //ship.geometry.firstMaterial.writesToDepthBuffer = NO;
    
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    scnView.technique = firstTechnique;
    
    // set the scene to the view
    scnView.scene = scene;
    
    // allows the user to manipulate the camera
    scnView.allowsCameraControl = YES;
        
    // show statistics such as fps and timing information
    scnView.showsStatistics = YES;

    // configure the view
    scnView.backgroundColor = [UIColor orangeColor];
    
    scnView.pointOfView = cameraNode;
    
    
    SCNNode *box = [SCNNode nodeWithGeometry:[SCNBox boxWithWidth:3 height:3 length:3 chamferRadius:0]];
    [scnView.scene.rootNode addChildNode:box];
    box.name = @"clipnode";
    box.categoryBitMask = 2;
    box.geometry.firstMaterial.transparency = 0.1;
    box.geometry.firstMaterial = [SCNMaterial material];
    box.geometry.shaderModifiers = @{SCNShaderModifierEntryPointFragment : @"_output.color.rgb = vec3(0.5);"};
    box.geometry.firstMaterial.writesToDepthBuffer = NO;
    box.renderingOrder = 100;
    //cameraNode.camera.technique = firstTechnique;
    
    //box.geometry.firstMaterial.transparent.contents = [UIImage imageNamed:@"art.scnassets/transparent.png"];
    
    
    /*ClipNode *clipNode = [[ClipNode alloc] init];
    clipNode.position = SCNVector3Make(0, 0, 0);
    [scnView.scene.rootNode addChildNode:clipNode];*/
    
    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
