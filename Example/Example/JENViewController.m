//
//  JENViewController.m
//  Example
//
//  Created by Jennifer Nordwall on 3/23/14.
//  Copyright (c) 2014 Jennifer Nordwall. All rights reserved.
//

#import "JENViewController.h"
#import "JENNode.h"
#import "JENTreeView.h"
#import "JENCustomNodeView.h"
#import "JENCustomDecorationView.h"

@implementation JENViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JENNode *leaf1 = [[JENNode alloc] init];
    leaf1.name = @"Anakin Skywalker";
    
    JENNode *leaf2 = [[JENNode alloc] init];
    leaf2.name = @"Padme Amidala";
    
    JENNode *leaf3 = [[JENNode alloc] init];
    leaf3.name = @"Beru Lars";
    
    JENNode *leaf4 = [[JENNode alloc] init];
    leaf4.name = @"Uncle Owen Lars";
    
    JENNode *leaf5 = [[JENNode alloc] init];
    leaf5.name = @"Mara Jade";
    
    JENNode *luke = [[JENNode alloc] init];
    luke.name = @"Luke Skywalker";
    luke.children = [NSSet setWithObjects:leaf1, leaf2, leaf3, leaf4, nil];
    
    JENNode *root = [[JENNode alloc] init];
    root.name = @"Ben Skywalker";
    root.children = [NSSet setWithObjects:leaf5, luke, nil];

	self.treeView.rootNode                  = root;
    self.treeView.dataSource                = self;
    self.treeView.backgroundColor           = [UIColor colorWithRed:0.0f/255.0f
                                                              green:127.0f/255.0f
                                                               blue:159.0f/255.0f
                                                              alpha:1.0f];

    self.treeView.alignChildren             = self.alignChildren.selectedSegmentIndex == 0;
    self.treeView.invertedLayout            = self.invertedLayout.selectedSegmentIndex != 0;
    self.treeView.showSubviews              = self.showViews.on;
    self.treeView.showSubviewFrames         = self.showViewFrames.on;

	[self.treeView reloadData];
	
    [self.alignChildren addTarget:self
                           action:@selector(layoutTreeview:)
                 forControlEvents:UIControlEventValueChanged];
    
    [self.invertedLayout addTarget:self
                            action:@selector(layoutTreeview:)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.decorationViewType addTarget:self
                                action:@selector(reloadTreeView:)
                      forControlEvents:UIControlEventValueChanged];
    
    [self.decorationViewType addTarget:self
                                action:@selector(reloadTreeView:)
                      forControlEvents:UIControlEventValueChanged];
    
    [self.showViews addTarget:self
                       action:@selector(reloadTreeView:)
             forControlEvents:UIControlEventValueChanged];
    
    [self.showViewFrames addTarget:self
                            action:@selector(reloadTreeView:)
                  forControlEvents:UIControlEventValueChanged];
}

-(void)layoutTreeview:(UISwitch*)sender {
    self.treeView.alignChildren		= self.alignChildren.selectedSegmentIndex == 0;
    self.treeView.invertedLayout	= self.invertedLayout.selectedSegmentIndex != 0;
    
    [self.treeView layoutGraph];
}

-(void)reloadTreeView:(UISwitch*)sender {
    self.treeView.showSubviews		= self.showViews.on;
    self.treeView.showSubviewFrames	= self.showViewFrames.on;
    
    [self.treeView reloadData];
}

-(UIView*)treeView:(JENTreeView*)treeView
    nodeViewForModelNode:(id<JENTreeViewModelNode>)modelNode {
    
    JENCustomNodeView* view = [[JENCustomNodeView alloc] init];
    view.name               = modelNode.name;
    view.backgroundColor    = [UIColor colorWithRed:0.0f/255.0f
                                              green:102.0f/255.0f
                                               blue:142.0f/255.0f
                                              alpha:1.0f];
    return view;
}

-(UIView<JENDecorationView>*)treeView:(JENTreeView*)treeView
                       decorationViewForModelNode:(id<JENTreeViewModelNode>)modelNode {
    
    JENCustomDecorationView *decorationView = [[JENCustomDecorationView alloc] init];
    
    decorationView.ortogonalConnection  = self.decorationViewType.selectedSegmentIndex == 0;
    decorationView.showView             = self.showViews.on;
    decorationView.showViewFrame        = self.showViewFrames.on;
    
    return decorationView;
}

@end
