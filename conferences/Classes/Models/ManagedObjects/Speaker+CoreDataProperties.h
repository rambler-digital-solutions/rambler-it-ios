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
//
// Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
// to delete and recreate this implementation file for your updated model.
//

#import "Speaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface Speaker (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *biography;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pictureLink;
@property (nullable, nonatomic, retain) NSSet<Lecture *> *lectures;
@property (nullable, nonatomic, retain) NSSet<SocialNetworkAccount *> *socialNetworkAccounts;

@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)addLecturesObject:(Lecture *)value;
- (void)removeLecturesObject:(Lecture *)value;
- (void)addLectures:(NSSet<Lecture *> *)values;
- (void)removeLectures:(NSSet<Lecture *> *)values;

- (void)addSocialNetworkAccountsObject:(SocialNetworkAccount *)value;
- (void)removeSocialNetworkAccountsObject:(SocialNetworkAccount *)value;
- (void)addSocialNetworkAccounts:(NSSet<SocialNetworkAccount *> *)values;
- (void)removeSocialNetworkAccounts:(NSSet<SocialNetworkAccount *> *)values;

@end

NS_ASSUME_NONNULL_END
