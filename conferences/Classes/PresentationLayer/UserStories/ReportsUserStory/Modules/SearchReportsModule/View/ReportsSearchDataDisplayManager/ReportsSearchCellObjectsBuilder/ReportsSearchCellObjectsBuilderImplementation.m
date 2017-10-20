// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ReportsSearchCellObjectsBuilderImplementation.h"

#import "LecturePlainObject.h"
#import "EventPlainObject.h"
#import "SpeakerPlainObject.h"
#import "TagModelObject.h"

#import "ReportEventTableViewCellObject.h"
#import "ReportSpeakerTableViewCellObject.h"
#import "ReportLectureTableViewCellObject.h"
#import "ReportSearchSectionTitleCellObject.h"
#import "UIColor+ConferencesPalette.h"
#import "DateFormatter.h"

#import "EXTScope.h"
#import "ReportsSearchViewOutput.h"

static NSString *const kSeparatorTagsString = @", ";
static const CGFloat kDefaultLineHeight = 3;

@interface ReportsSearchCellObjectsBuilderImplementation()

@property (nonatomic, weak) id <ReportsSearchViewOutput> viewOutput;

@end

@implementation ReportsSearchCellObjectsBuilderImplementation

- (instancetype)initWithDateFormatter:(DateFormatter *)dateFormatter
                       withViewOutput:(id<ReportsSearchViewOutput>)viewOutput{
    self = [super init];
    if (self) {
        _dateFormatter = dateFormatter;
        _viewOutput = viewOutput;
    }
    return self;
}

- (ReportEventTableViewCellObject *)eventCellObjectFromPlainObject:(EventPlainObject *)event
                                                      selectedText:(NSString *)selectedText {
    
    NSString *eventDate = [self.dateFormatter obtainDateWithDayMonthYearFormat:event.startDate];
    
    NSAttributedString *highlightedTitle = [self highlightInString:event.name
                                                      selectedText:selectedText
                                                             color:[UIColor rcf_lightBlueColor]];
    NSString *stringFromTags = [self obtainTagsStringFromEvent:event];
    NSAttributedString *highlightedTags = [self highlightInString:stringFromTags
                                                     selectedText:selectedText
                                                            color:[UIColor rcf_lightBlueColor]];
    ReportEventTableViewCellObject *cellObject = [ReportEventTableViewCellObject objectWithEvent:event
                                                                                         andDate:eventDate
                                                                                            tags:highlightedTags
                                                                                 highlightedText:highlightedTitle];
    return cellObject;
}

- (ReportLectureTableViewCellObject *)lectureCellObjectFromPlainObject:(LecturePlainObject *)lecture
                                                          selectedText:(NSString *)selectedText {
    NSAttributedString *highlightedSpeakerName = [self highlightInString:lecture.speaker.name
                                                            selectedText:selectedText
                                                                   color:[UIColor rcf_lightBlueColor]];
    NSAttributedString *highlightedName = [self highlightInString:lecture.name
                                                     selectedText:selectedText
                                                            color:[UIColor rcf_lightBlueColor]];
    NSString *tagsString = [self obtainTagsStringFromLecture:lecture];
    NSAttributedString *highlightedTags = [self tagStringFromString:tagsString
                                                         withColor:[UIColor rcf_lightBlueColor]];
    @weakify(self);
    ReportLectureTableViewCellObject *cellObject = [ReportLectureTableViewCellObject objectWithLecture:lecture
                                                                                                  tags:highlightedTags
                                                                                           speakerName:highlightedSpeakerName
                                                                                       highlightedText:highlightedName
                                                                                             tagAction:^(NSString *tag) {
                                                                                                 @strongify(self);
                                                                                                 [self.viewOutput didSelectTag:tag];
                                                                                             }];
    return cellObject;
}

- (ReportSpeakerTableViewCellObject *)speakerCellObjectFromPlainObject:(SpeakerPlainObject *)speaker
                                                          selectedText:(NSString *)selectedText {
    NSAttributedString *highlightedString = [self highlightInString:speaker.name
                                                       selectedText:selectedText
                                                              color:[UIColor rcf_lightBlueColor]];
    ReportSpeakerTableViewCellObject *cellObject = [ReportSpeakerTableViewCellObject objectWithSpeaker:speaker
                                                                                       highlightedText:highlightedString];
    return cellObject;
}

- (ReportSearchSectionTitleCellObject *)sectionCellObjectWithTitle:(NSString *)title
                                                   backgroundColor:(UIColor *)color {
    return [ReportSearchSectionTitleCellObject objectWithSectionTitle:title
                                                      backgroundColor:color];
}

#pragma mark - private methods

- (NSAttributedString *)highlightInString:(NSString *)string
                             selectedText:(NSString *)selectedText
                                    color:(UIColor *)color {
    if (!string) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *highlightedString = [[NSMutableAttributedString alloc] initWithString:string];
    if ([selectedText length] != 0) {
        NSArray *separatedTextArray = [selectedText componentsSeparatedByString:@" "];
        
        for (NSString *separatedString in separatedTextArray) {
            if (separatedString.length == 0) {
                continue;
            }
            
            NSRange range = [[string lowercaseString] rangeOfString:separatedString];
            [highlightedString addAttribute:NSForegroundColorAttributeName
                                      value:color
                                      range:range];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:kDefaultLineHeight];
            [highlightedString addAttribute:NSParagraphStyleAttributeName
                                      value:style
                                      range:NSMakeRange(0, highlightedString.length)];
        }
    }
    return [highlightedString copy];
}

- (NSAttributedString *)tagStringFromString:(NSString *)string
                                  withColor:(UIColor *)color {
    NSMutableAttributedString *highlightedString = [[NSMutableAttributedString alloc] initWithString:string];

    if ([string length] != 0) {
        NSArray *separatedStrings = [string componentsSeparatedByString:@", "];
        
        for (NSString *separatedString in separatedStrings) {
            if (separatedString.length == 0) {
                continue;
            }
            
            NSRange range = [[string lowercaseString] rangeOfString:separatedString];
            [highlightedString addAttribute:NSForegroundColorAttributeName
                                      value:color
                                      range:range];
        
            [highlightedString addAttribute:NSLinkAttributeName
                                      value:separatedString
                                      range:range];
        }
    }
    return [highlightedString copy];
}

- (NSString *)obtainTagsStringFromEvent:(EventPlainObject *)event {
    NSMutableArray *allTags = [NSMutableArray array];
    for (LecturePlainObject *lecture in event.lectures) {
        [allTags addObjectsFromArray:[lecture.tags allObjects]];
    }
    NSArray *arrayWithoutDuplicates = [[NSSet setWithArray: allTags] allObjects];
    
    NSArray *tagsNames = [arrayWithoutDuplicates valueForKey:TagModelObjectAttributes.name];
    NSString *stringFromTags = [tagsNames count] != 0 ? [tagsNames componentsJoinedByString:kSeparatorTagsString] : @"" ;
    
    return stringFromTags;
}

- (NSString *)obtainTagsStringFromLecture:(LecturePlainObject *)lecture {
    NSArray *allTags = [lecture.tags allObjects];
    NSArray *tagsNames = [allTags valueForKey:TagModelObjectAttributes.name];
    NSString *stringFromTags = [tagsNames count] != 0 ? [tagsNames componentsJoinedByString:kSeparatorTagsString] : @"" ;
    
    return stringFromTags;
}

@end
