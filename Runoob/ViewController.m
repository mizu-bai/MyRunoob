//
//  Controller.m
//  Runoob
//
//  Created by mizu-bai on 2021/5/9.
//

#import "ViewController.h"
#import "MZItem.h"
#import "MZGroup.h"
#import "MZItemCell.h"
#import <Ono.h>


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *models;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)setModels:(NSArray *)models {
    _models = models;
    // Change to main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://www.runoob.com"];
    [self requestWebPageWithURL:url];
    NSLog(@"%@", self.models);
}

#pragma mark - request web page

- (void)requestWebPageWithURL:(NSURL *)url {
    // config request
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
    [requestM setHTTPMethod:@"GET"];
    [requestM setTimeoutInterval:10.0];
    // session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[requestM copy] completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable connectionError) {
        if (connectionError) {
            NSLog(@"Error: %@", connectionError);
            return;
        }
        NSHTTPURLResponse *httpurlResponse = (NSHTTPURLResponse *) response;
        if (httpurlResponse.statusCode == 200 || httpurlResponse.statusCode == 304) {
            // process data
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            self.models = [self htmlParserWith:html];
        } else {
            NSLog(@"Error: %zd", httpurlResponse.statusCode);
        }
    }];
    [dataTask resume];
}

#pragma mark - HTML Parser

- (NSArray *)htmlParserWith:(NSString *)html {
    NSMutableArray *arrayM = [NSMutableArray array];
    ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithString:html encoding:NSUTF8StringEncoding error:NULL];
    ONOXMLElement *homeElement = [document firstChildWithXPath:@"//*[@class='col middle-column-home']"];
    [homeElement enumerateElementsWithXPath:@"//div[contains(@class, 'desktop')]" usingBlock:^(ONOXMLElement * _Nonnull codelistElement, NSUInteger idx, BOOL * _Nonnull stop) {
        ONOXMLElement *groupElement = [codelistElement firstChildWithXPath:@"h2"];
        NSMutableArray *arrayItem = [NSMutableArray array];
        [codelistElement enumerateElementsWithXPath:@"a" usingBlock:^(ONOXMLElement * _Nonnull itemElement, NSUInteger idx, BOOL * _Nonnull stop) {
            MZItem *item = [[MZItem alloc] init];
            [itemElement.children enumerateObjectsUsingBlock:^(ONOXMLElement * _Nonnull detailElement, NSUInteger idx, BOOL * _Nonnull stop) {
                [item setValue:[[itemElement firstChildWithXPath:@"h4"] stringValue] forKey:@"title"];
                [item setValue:[itemElement valueForAttribute:@"href"] forKey:@"link"];
                [item setValue:[[itemElement firstChildWithXPath:@"img"] valueForAttribute:@"src"] forKey:@"imageBase64"];
                [item setValue:[[itemElement firstChildWithXPath:@"strong"] stringValue] forKey:@"detail"];

            }];
            [arrayItem addObject:item];
        }];
        MZGroup *group = [[MZGroup alloc] init];
        [group setValue:[groupElement stringValue] forKey:@"title"];
        [group setValue:[arrayItem copy] forKey:@"items"];
        if (group.title != nil && [group.items count] != 0) {
            [arrayM addObject:group];
        }
    }];
    return [arrayM copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.models count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MZGroup *group = self.models[(NSUInteger) section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MZGroup *group = self.models[(NSUInteger) indexPath.section];
    MZItem *item = group.items[(NSUInteger) indexPath.row];
    MZItemCell *cell = [MZItemCell itemCellWithTableView:tableView];
    cell.item = item;
    return cell;
}

#pragma mark - Table view delegate

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MZGroup *group = self.models[(NSUInteger) section];
    return group.title;
}

@end
