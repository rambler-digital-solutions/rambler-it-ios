//
//  RamblerTyphoonAssemblyTests.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RamblerTyphoonAssemblyTests.h"

#import "RamblerTyphoonAssemblyTestsTypeDescriptor.h"
#import "RamblerTyphoonAssemblyTestUtilities.h"
#import "OCMock.h"

@interface RamblerTyphoonAssemblyTests ()

@property (nonatomic, strong) id realInstance;
@property (nonatomic, strong) id partitialMock;

@end

@implementation RamblerTyphoonAssemblyTests

- (void)tearDown {
    self.realInstance = nil;
    
    [self.partitialMock stopMocking];
    self.partitialMock = nil;
    
    [super tearDown];
}

- (void)prepateAssemblyTestClass:(Class)clazz {
    self.realInstance  = [clazz alloc];
    self.partitialMock = OCMPartialMock(self.realInstance);
    OCMStub([self.partitialMock alloc]).andReturn(self.partitialMock);
}

#pragma mark - Public

- (void)verifyTargetDependency:(id)targetObject
                withDescriptor:(RamblerTyphoonAssemblyTestsTypeDescriptor *)targetTypeDescriptor {
    XCTAssertTrue([targetObject isKindOfClass:targetTypeDescriptor.describedClass],
                  @"Неверный класс объекта %@", targetObject);
    for (Protocol *protocol in targetTypeDescriptor.conformingProtocols) {
        XCTAssertTrue([targetObject conformsToProtocol:protocol],
                      @"Объект %@ не имплементирует протокол <%@>", targetObject, NSStringFromProtocol(protocol));
    }
}

- (void)verifyTargetDependency:(id)targetObject
                withDescriptor:(RamblerTyphoonAssemblyTestsTypeDescriptor *)targetTypeDescriptor
                  dependencies:(NSArray *)dependencies {
    // Verifying the object class
    [self verifyTargetDependency:targetObject
                  withDescriptor:targetTypeDescriptor];

    NSMutableDictionary *allProperties =
        [[RamblerTyphoonAssemblyTestUtilities propertiesForHierarchyOfClass:targetTypeDescriptor.describedClass] mutableCopy];
    NSArray *propertyNames = [allProperties allKeys];

    // Verifying that target object has all needed dependencies
    for (NSString *propertyName in dependencies) {
        XCTAssertTrue([propertyNames containsObject:propertyName], @"For object %@ has not been found property %@", targetObject,
                      propertyName);
    }

    // Filtering the properties of the class
    for (NSString *propertyName in propertyNames) {
        if (![dependencies containsObject:propertyName] ) {
            [allProperties removeObjectForKey:propertyName];
        }
    }
    
    // Verifying dependencies
    [self verifyTargetObject:targetObject
                dependencies:allProperties];
}

#pragma mark - Obsolete methods

- (void)verifyTargetDependency:(id)targetDependency
                     withClass:(Class)targetClass {
    [self verifyTargetDependency:targetDependency
                       withClass:targetClass
                    dependencies:nil];
}

- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
                  dependencies:(NSArray *)dependencies {
    RamblerTyphoonAssemblyTestsTypeDescriptor *typeDescriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass];
    [self verifyTargetDependency:targetObject
                  withDescriptor:typeDescriptor
                    dependencies:dependencies];
}

- (void)verifyTargetDependency:(id)targetDependency
                 withProtocols:(NSArray *)conformingProtocols {
    [self verifyTargetDependency:targetDependency
                   withProtocols:conformingProtocols
                    dependencies:nil];
}

- (void)verifyTargetDependency:(id)targetObject
                 withProtocols:(NSArray *)conformingProtocols
                  dependencies:(NSArray *)dependencies {
    RamblerTyphoonAssemblyTestsTypeDescriptor *typeDescriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithProtocols:conformingProtocols];
    [self verifyTargetDependency:targetObject
                  withDescriptor:typeDescriptor
                    dependencies:dependencies];
}

- (void)verifyTargetDependency:(id)targetDependency
                     withClass:(Class)targetClass
                  andProtocols:(NSArray *)conformingProtocols {
    [self verifyTargetDependency:targetDependency
                       withClass:targetClass
                    andProtocols:conformingProtocols
                    dependencies:nil];
}

- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
                  andProtocols:(NSArray *)conformingProtocols
                  dependencies:(NSArray *)dependencies {
    RamblerTyphoonAssemblyTestsTypeDescriptor *typeDescriptor = [RamblerTyphoonAssemblyTestsTypeDescriptor descriptorWithClass:targetClass
                                                                                                                  andProtocols:conformingProtocols];
    [self verifyTargetDependency:targetObject
                  withDescriptor:typeDescriptor
                    dependencies:dependencies];
}

#pragma mark - Helpers

- (void)verifyTargetObject:(id)targetObject
              dependencies:(NSDictionary *)dependencies {
    for (NSString *propertyName in dependencies) {
        NSString *dependencyExpectedType = dependencies[propertyName];
        RamblerPropertyType propertyType = [RamblerTyphoonAssemblyTestUtilities propertyTypeByString:dependencyExpectedType];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id dependencyObject = [targetObject performSelector:NSSelectorFromString(propertyName)];
#pragma clang diagnostic pop

        switch (propertyType) {
            case RamblerId: {
                XCTAssertNotNil(dependencyObject, @"Свойство %@ объекта %@ не должно быть nil", propertyName, targetObject);
                break;
            }

            case RamblerClass: {
                Class expectedClass = NSClassFromString(dependencyExpectedType);
                XCTAssertTrue([dependencyObject isKindOfClass:expectedClass],
                              @"Неверный класс свойства %@ объекта %@", propertyName, targetObject);
                break;
            }

            case RamblerProtocol: {
                RamblerTyphoonAssemblyTestsTypeDescriptor *propertyTypeDescriptor =
                    [RamblerTyphoonAssemblyTestUtilities typeDescriptorFromPropertyWithProtocol:dependencyExpectedType];
                [self verifyTargetDependency:dependencyObject
                              withDescriptor:propertyTypeDescriptor];
                break;
            }

            // We don't verify blocks and primitive types
            default:
                break;
        }
    }
}

@end
