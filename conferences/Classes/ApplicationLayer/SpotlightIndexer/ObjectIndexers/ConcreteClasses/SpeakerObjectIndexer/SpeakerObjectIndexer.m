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

#import "SpeakerObjectIndexer.h"

#import "SpeakerModelObject.h"
#import "SpotlightIndexerConstants.h"

#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation SpeakerObjectIndexer

#pragma mark - Overriden methods

- (BOOL)canIndexObjectWithType:(NSString *)objectType {
    return [objectType isEqualToString:NSStringFromClass([SpeakerModelObject class])];
}

- (CSSearchableItem *)searchableItemForObject:(SpeakerModelObject *)object {
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeJSON];
    attributeSet.title = object.name;
    
    NSString *speakerDescription = [self generateSpeakerDescriptionForSpeaker:object];
    attributeSet.contentDescription = speakerDescription;
    
    NSArray *keywords = [self generateKeywordsForSpeaker:object];
    attributeSet.keywords = keywords;
    
    NSString *uniqueIdentifier = [self identifierForObject:object];
    NSString *domainIdentifier = NSStringFromClass([SpeakerModelObject class]);
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:uniqueIdentifier
                                                               domainIdentifier:domainIdentifier
                                                                   attributeSet:attributeSet];
    item.expirationDate = [NSDate distantFuture];
    return item;
}

#pragma mark - Private methods

- (NSString *)generateSpeakerDescriptionForSpeaker:(SpeakerModelObject *)speaker {
    NSMutableArray *speakerDescriptionParts = [NSMutableArray new];
    
    if (speaker.job && speaker.job.length > 0) {
        [speakerDescriptionParts addObject:speaker.job];
    }
    
    if (speaker.company && speaker.company.length > 0) {
        [speakerDescriptionParts addObject:speaker.company];
    }
    
    NSString *speakerDescription = [speakerDescriptionParts componentsJoinedByString:@" @ "];
    if (speakerDescription.length == 0 && speaker.biography && speaker.biography.length > 0) {
        speakerDescription = speaker.biography;
    }

    return speakerDescription;
}

- (NSArray *)generateKeywordsForSpeaker:(SpeakerModelObject *)speaker {
    NSMutableArray *keywords = [NSMutableArray new];
    [keywords addObjectsFromArray:[speaker.name componentsSeparatedByString:@" "]];
    
    if (speaker.company && speaker.company.length > 0) {
        [keywords addObject:speaker.company];
    }

    return [keywords copy];
}

@end
