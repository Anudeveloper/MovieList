//
//  ViewController.h
//  MovieDatabase
//
//  Created by daksha on 8/16/17.
//  Copyright © 2017 demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *popularMovie;
    NSMutableArray *highRatedMovie;
    NSMutableArray *allMovies;
    
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

