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

#import "ManagedObjectMappingProvider.h"

#import "SocialNetworkAccountManagedObject.h"
#import "EventManagedObject.h"
#import "MetaEventManagedObject.h"
#import "TechManagedObject.h"
#import "LectureManagedObject.h"
#import "SpeakerManagedObject.h"
#import "TagManagedObject.h"
#import "LectureMaterialManagedObject.h"

#import "SocialNetworkType.h"

#import "EntityNameFormatter.h"

#import <EasyMapping/EasyMapping.h>
#import "NSString+RCFCapitalization.h"

@implementation ManagedObjectMappingProvider

- (EKManagedObjectMapping *)mappingForManagedObjectModelClass:(Class)managedObjectModelClass {
    NSString *managedObjectModelStringName = NSStringFromClass(managedObjectModelClass);
    NSString *mappingName = [NSString stringWithFormat:@"%@Mapping", managedObjectModelStringName];
    NSString *decapitalizedMappingName = [mappingName rcf_decapitalizedStringSavingCase];
    
    EKManagedObjectMapping *selectedMapping = nil;
    SEL mappingSelector = NSSelectorFromString(decapitalizedMappingName);
    if ([self respondsToSelector:mappingSelector]) {
        selectedMapping = ((EKManagedObjectMapping* (*)(id, SEL))[self methodForSelector:mappingSelector])(self, mappingSelector);
    }
    return selectedMapping;
}

- (EKManagedObjectMapping *)eventManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"id" : NSStringFromSelector(@selector(eventId)),
                                 @"attributes.name" : NSStringFromSelector(@selector(name)),
                                 };
    Class entityClass = [EventManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(eventId));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                                  
                                                  [mapping mapKeyPath:@"attributes.starts_at"
                                                           toProperty:NSStringFromSelector(@selector(startDate))
                                                    withDateFormatter:self.dateFormatter];
                                                  [mapping mapKeyPath:@"attributes.ends_at"
                                                           toProperty:NSStringFromSelector(@selector(endDate))
                                                    withDateFormatter:self.dateFormatter];
                                                  [mapping hasOne:[MetaEventManagedObject class]
                                                       forKeyPath:@"attributes.brand"
                                                      forProperty:NSStringFromSelector(@selector(metaEvent))
                                                withObjectMapping:[self metaEventManagedObjectMapping]];
                                                  [mapping hasOne:[TechManagedObject class]
                                                       forKeyPath:@"attributes.tech"
                                                      forProperty:NSStringFromSelector(@selector(tech))
                                                withObjectMapping:[self techManagedObjectMapping]];
                                                  [mapping hasMany:[LectureManagedObject class]
                                                        forKeyPath:@"attributes.lectures"
                                                       forProperty:NSStringFromSelector(@selector(lectures))
                                                 withObjectMapping:[self lectureManagedObjectMapping]];
                                              }];
}

- (EKManagedObjectMapping *)metaEventManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"id" : NSStringFromSelector(@selector(metaEventId)),
                                 @"name" : NSStringFromSelector(@selector(name)),
                                 @"description" : NSStringFromSelector(@selector(metaEventDescription)),
                                 @"home_page" : NSStringFromSelector(@selector(websiteUrlPath)),
                                 @"logo" : NSStringFromSelector(@selector(imageUrlPath))
                                 };
    Class entityClass = [MetaEventManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(metaEventId));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                              }];
}

- (EKManagedObjectMapping *)techManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"id" : NSStringFromSelector(@selector(techId)),
                                 @"name" : NSStringFromSelector(@selector(name)),
                                 @"color" : NSStringFromSelector(@selector(color))
                                 };
    Class entityClass = [TechManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(techId));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                              }];
}

- (EKManagedObjectMapping *)lectureManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"id" : NSStringFromSelector(@selector(lectureId)),
                                 @"title" : NSStringFromSelector(@selector(name)),
                                 @"description" : NSStringFromSelector(@selector(lectureDescription))
                                 };
    Class entityClass = [LectureManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(lectureId));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                                  [mapping hasOne:[SpeakerManagedObject class]
                                                       forKeyPath:@"speaker"
                                                      forProperty:NSStringFromSelector(@selector(speaker))
                                                withObjectMapping:[self speakerManagedObjectMapping]];
                                                  [mapping hasMany:[TagManagedObject class]
                                                        forKeyPath:@"tags"
                                                       forProperty:NSStringFromSelector(@selector(tags))
                                                 withObjectMapping:[self tagManagedObjectMapping]];
                                                  [mapping hasMany:[LectureMaterialManagedObject class]
                                                        forKeyPath:@"materials"
                                                       forProperty:NSStringFromSelector(@selector(lectureMaterials))
                                                 withObjectMapping:[self lectureMaterialManagedObjectMapping]];
                                              }];
}

- (EKManagedObjectMapping *)speakerManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"id" : NSStringFromSelector(@selector(speakerId)),
                                 @"bio" : NSStringFromSelector(@selector(biography)),
                                 @"job" : NSStringFromSelector(@selector(job)),
                                 @"company" : NSStringFromSelector(@selector(company)),
                                 @"image" : NSStringFromSelector(@selector(imageLink))
                                 };
    Class entityClass = [SpeakerManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(speakerId));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                                  [mapping mapKeyPath:@"@self"
                                                           toProperty:NSStringFromSelector(@selector(name))
                                                       withValueBlock:[self compoundNameValueBlock]];
                                                  [mapping hasMany:[SocialNetworkAccountManagedObject class]
                                                        forKeyPath:@"social_profiles"
                                                       forProperty:NSStringFromSelector(@selector(socialNetworkAccounts))
                                                 withObjectMapping:[self socialNetworkAccountManagedObjectMapping]];
                                              }];
}

- (EKManagedObjectMapping *)socialNetworkAccountManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"link" : NSStringFromSelector(@selector(profileLink))
                                 };
    Class entityClass = [SocialNetworkAccountManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(profileLink));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                                  [mapping mapKeyPath:@"network"
                                                           toProperty:NSStringFromSelector(@selector(type))
                                                       withValueBlock:[self socialNetworkTypeValueBlock]];
                                              }];
}

- (EKManagedObjectMapping *)tagManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"id" : NSStringFromSelector(@selector(tagId)),
                                 @"name" : NSStringFromSelector(@selector(name)),
                                 @"slug" : NSStringFromSelector(@selector(slug))
                                 };
    Class entityClass = [TagManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(tagId));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                              }];
}

- (EKManagedObjectMapping *)lectureMaterialManagedObjectMapping {
    NSDictionary *properties = @{
                                 @"id" : NSStringFromSelector(@selector(lectureMaterialId)),
                                 @"link" : NSStringFromSelector(@selector(link)),
                                 @"name" : NSStringFromSelector(@selector(name))
                                 };
    Class entityClass = [LectureMaterialManagedObject class];
    NSString *entityName = [self.entityNameFormatter transformToEntityNameClass:entityClass];
    return [EKManagedObjectMapping mappingForEntityName:entityName
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = NSStringFromSelector(@selector(lectureMaterialId));
                                                  [mapping mapPropertiesFromDictionary:properties];
                                              }];
}

#pragma mark - Value Blocks

- (EKManagedMappingValueBlock)compoundNameValueBlock {
    return ^id(NSString *key, NSDictionary *value, NSManagedObjectContext *context) {
        NSString *firstName = value[@"first_name"];
        NSString *lastName = value[@"last_name"];
        return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    };
}

- (EKManagedMappingValueBlock)socialNetworkTypeValueBlock {
    static NSDictionary *socialNetworkTypes;
    if (!socialNetworkTypes) {
        socialNetworkTypes = @{
                               @"Facebook" : @(SocialNetworkFacebookType),
                               @"Twitter" : @(SocialNetworkTwitterType),
                               @"GitHub" : @(SocialNetworkGitHubType),
                               @"LinkedIn" : @(SocialNetworkLinkedInType),
                               @"Vkontakte" : @(SocialNetworkVkontakteType)
                               };
    }
    return ^id(NSString *key, NSString *value, NSManagedObjectContext *context) {
        NSNumber *type = socialNetworkTypes[value] ?: @(SocialNetworkUndefinedType);
        return type;
    };
}

@end
