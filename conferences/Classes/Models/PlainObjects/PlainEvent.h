//
//  PlainEvent.h
//  Conferences
//
//  Created by Karpushin Artem on 25/10/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PlainEvent : NSObject

// пока окончательно не сформировалась модель, проперти оставил в таком виде
// добавить в модель цвет фона ивента
// добавить в модель eventTags
// добавить в модель изображение ивента
@property (nonatomic, strong, readwrite) NSString *eventDescription;
@property (nonatomic, strong, readwrite) NSString *liveStreamLink;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *objectId;
@property (nonatomic, strong, readwrite) NSDate *startDate;
@property (nonatomic, strong, readwrite) NSDate *endDate;
@property (nonatomic, strong, readwrite) NSString *timePadID;
@property (nonatomic, strong, readwrite) NSString *twitterLink;
@property (nonatomic, strong, readwrite) NSArray *lectures;
@property (nonatomic, strong, readwrite) NSArray *registrationQuestions;
@property (nonatomic, strong, readwrite) NSString *eventTags;
@property (nonatomic, strong, readwrite) UIColor *backgroundColor;
@property (nonatomic, strong, readwrite) UIImageView *eventImage;

@end
