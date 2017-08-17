//
//  ViewController.m
//  MovieDatabase
//
//  Created by daksha on 8/16/17.
//  Copyright © 2017 demo. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
//#import "UIImageView+WebCache.h"
#import "CustomCollectionViewCell.h"

@interface ViewController ()
{
    NSArray *title;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    title = [NSArray arrayWithObjects:@"New in Theatres:",@"Popular:",@"Highest Rated This Year:", nil];
    popularMovie=[[NSMutableArray alloc]init];
    highRatedMovie=[[NSMutableArray alloc]init];
    allMovies=[[NSMutableArray alloc]init];
    [self getPopularMoviesFromApi];
    [self getAllMoviesFromApi];
    [self getHighRatedMoviesFromApi];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getPopularMoviesFromApi{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager GET:@"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=8329f3c5d69a8ba0ac904f05f2f1f4ae" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [popularMovie addObjectsFromArray:[responseObject objectForKey:@"results"]];
        [self.myTableView reloadData];
        NSLog(@"JSON: %@", popularMovie);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)getAllMoviesFromApi{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager GET:@"https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2017-07-17&primary_release_date.lte=2017-8-17&api_key=8329f3c5d69a8ba0ac904f05f2f1f4ae" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [allMovies addObjectsFromArray:[responseObject objectForKey:@"results"]];
        [self.myTableView reloadData];
        NSLog(@"JSON: %@", popularMovie);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)getHighRatedMoviesFromApi{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager GET:@"https://api.themoviedb.org/3/discover/movie?api_key=8329f3c5d69a8ba0ac904f05f2f1f4ae&certification_country=US&certification=R&sort_by=vote_average.desc&primary_release_date.gte=2016-08-16&primary_release_date.lte=2017-8-16" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        for (NSDictionary* dict in [responseObject objectForKey:@"results"]) {
            if ([[dict objectForKey:@"vote_count"] integerValue]>500) {
                [highRatedMovie addObject:dict];
            }
        }
        
        [self.myTableView reloadData];
       
    
        NSLog(@"JSON: %@", highRatedMovie);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        NSArray *title = [NSArray arrayWithObjects:@"New in Theatres:",@"Popular:",@"Highest Rated This Year:", nil];
//        headerView.title.text = [title objectAtIndex:indexPath.section];
//        
//        reusableview = headerView;
//    }
//    
//    
//    return reusableview;
//}

/*- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize size=CGSizeMake(self.myCollectionView.frame.size.width, 200);
    return size;
    
}*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return title.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    }

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return title[section];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cell";
    CustomTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //TableView cell setup
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	if (indexPath.section == 0) {
		[cell loadContent: allMovies] ;
	}else if (indexPath.section == 1){
		[cell loadContent: popularMovie] ;
	}else{
		[cell loadContent: highRatedMovie] ;
	}
	
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


@end
