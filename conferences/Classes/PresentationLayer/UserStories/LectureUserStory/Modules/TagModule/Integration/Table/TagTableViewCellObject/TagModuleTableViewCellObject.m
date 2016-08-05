//
// TagModuleTableViewCellObject.m
// LiveJournal
// 
// Created by Golovko Mikhail on 15/12/15.
// Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "TagModuleTableViewCellObject.h"
#import "TagModuleTableViewCell.h"
#import "TagEditMediator.h"
#import "TagModuleOutput.h"
#import "TagModuleInput.h"
#import "TagMediatorInput.h"
#import "TagObjectDescriptor.h"

@implementation TagModuleTableViewCellObject

#pragma mark - NINibCellObject

- (instancetype)initWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                           mediatorInput:(id < TagMediatorInput > )mediatorInput{
    self = [super init];
    if (self) {
        _objectDescriptor = objectDescriptor;
        _mediatorInput = mediatorInput;
        _height = 44.0;
    }

    return self;
}

+ (instancetype)objectWithObjectDescriptor:(TagObjectDescriptor *)objectDescriptor
                             mediatorInput:(id <TagMediatorInput>)mediatorInput {
    return [[self alloc] initWithObjectDescriptor:objectDescriptor
                                    mediatorInput:mediatorInput];
}

- (UINib *)cellNib {
    NSString *nibName = NSStringFromClass([TagModuleTableViewCell class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [UINib nibWithNibName:nibName
                          bundle:bundle];
}

- (Class)cellClass {
    return [TagModuleTableViewCell class];
}

@end