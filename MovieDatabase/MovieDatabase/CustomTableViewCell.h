//
//  CustomTableViewCell.h
//  MovieDatabase
//
//  Created by daksha on 8/16/17.
//  Copyright © 2017 demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray* contentArray;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

-(void)loadContent:(NSArray*)arrayContent;
@end
