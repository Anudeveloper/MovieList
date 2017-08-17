//
//  CustomTableViewCell.m
//  MovieDatabase
//
//  Created by daksha on 8/16/17.
//  Copyright © 2017 demo. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "CustomCollectionViewCell.h"
//#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadContent:(NSArray*)arrayContent {
	self.contentArray = arrayContent;
	[self.myCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	
	return [self.contentArray count];
	
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"Cell";
	CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	
	
		cell.lblMovieTitle.text = [[self.contentArray objectAtIndex:indexPath.row]valueForKey:@"original_title"];
        cell.movieImageView.layer.cornerRadius = 10.0;
        cell.movieImageView.clipsToBounds = YES;
		NSString * urlStr = [[NSString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@",[[self.contentArray objectAtIndex:indexPath.row]valueForKey:@"poster_path"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		NSURL * imgUrl = [NSURL URLWithString:urlStr];
		[cell.movieImageView setImageWithURL:imgUrl placeholderImage:nil];
    
    

	
	return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	
	return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize size=CGSizeMake(self.myCollectionView.frame.size.width, 200);
    return size;
    
}


@end
