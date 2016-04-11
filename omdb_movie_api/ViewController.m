//
//  ViewController.m
//  omdb_movie_api
//
//  Created by tops on 3/31/16.
//  Copyright (c) 2016 viewc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tbl_vw,txt_nm,txt_year,img_vw;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [tbl_vw setBackgroundView:nil];
    [tbl_vw setBackgroundColor:[UIColor clearColor]];
    
    tbl_vw.dataSource=self;
    tbl_vw.delegate=self;
    
    arr_img=[[NSArray alloc]init];
    
    
  }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arr_img.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=nil;
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
   /* for (int i=0; i<arr_img.count; i++)
    {
        <#statements#>
    }
    return cell;*/

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dict allKeys]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
     cell.textLabel.text=[[dict allKeys]objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[[dict allValues]objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor clearColor]];
   
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_action:(id)sender
{
    [self.view endEditing:YES];
    
    if ([txt_nm.text length] == 0 && [txt_year.text length] == 0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Movie Details" message:@"Please enter movie name & year..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.alertViewStyle=UIAlertViewStyleDefault;
        [alert show];
    }
    else
    {
    
    if ([txt_nm.text length] == 0) // checking the length of the text in UITextField
    {
        
    
        UIAlertView *alert_nm=[[UIAlertView alloc]initWithTitle:@"Movie Name" message:@"Please enter movie name..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert_nm.alertViewStyle=UIAlertViewStyleDefault;
        [alert_nm show];
    }
    if ([txt_year.text length] == 0) // checking the length of the text in UITextField
    {

        UIAlertView *alert_year=[[UIAlertView alloc]initWithTitle:@"Movie Year" message:@"Please enter year..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert_year.alertViewStyle=UIAlertViewStyleDefault;
       
        [alert_year show];
    }
    if (txt_nm.text.length>0 && txt_year.text.length>0)
    {
        
    
    NSString *st_format=[NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&y=%@&plot=short&r=json",[txt_nm.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],txt_year.text];
    NSURL *url=[NSURL URLWithString:st_format];
    NSData *data=[NSData dataWithContentsOfURL:url];
    dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"%@",dict);
    
    [tbl_vw reloadData];
    [tbl_vw setBackgroundView:nil];
    [tbl_vw setBackgroundColor:[UIColor clearColor]];
        
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(192, 93, 150, 200)];
    NSURL *url_img=[NSURL URLWithString:[dict objectForKey:@"Poster"]];
    NSData *data_img=[NSData dataWithContentsOfURL:url_img];
    img_vw.image=[UIImage imageWithData:data_img];
    [self.view addSubview:img];
    }
    }
}

@end


