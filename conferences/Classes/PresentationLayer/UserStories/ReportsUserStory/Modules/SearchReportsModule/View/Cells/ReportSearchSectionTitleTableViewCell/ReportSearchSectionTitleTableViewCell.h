//
//  ReportSearchSectionTitleTableViewCell.h
//  Conferences
//
//  Created by k.zinovyev on 15.08.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NICellFactory.h>

@interface ReportSearchSectionTitleTableViewCell : UITableViewCell  <NICell>

@property (nonatomic, weak) IBOutlet UILabel *sectionTitle;

@end
