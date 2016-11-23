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

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "ApplicationConfigurator.h"
#import "ApplicationConfiguratorImplementation.h"

#import <MagicalRecord/MagicalRecord.h>
#import "MessagesConstants.h"

@interface ApplicationConfiguratorTests : XCTestCase

@property (nonatomic, strong) ApplicationConfiguratorImplementation *applicationConfigurator;
@property (nonatomic, strong) id magicalRecordMock;
@property (nonatomic, strong) id managedObjectModelClassMock;
@property (nonatomic, strong) id migrationManager;
@property (nonatomic, strong) NSFileManager *fileManagerMock;
@property (nonatomic, strong) id bundleMock;

@end

@implementation ApplicationConfiguratorTests

- (void)setUp {
    [super setUp];
    
    self.applicationConfigurator = [ApplicationConfiguratorImplementation new];
    self.magicalRecordMock = OCMClassMock([MagicalRecord class]);
    OCMStub([self.magicalRecordMock setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:OCMOCK_ANY]);

    self.managedObjectModelClassMock = OCMClassMock([NSManagedObjectModel class]);
    OCMStub([self.managedObjectModelClassMock MR_defaultManagedObjectModel]).andReturn(self.managedObjectModelClassMock);
    self.fileManagerMock = OCMClassMock([NSFileManager class]);
    self.applicationConfigurator.fileManager = self.fileManagerMock;
    self.migrationManager = OCMClassMock([NSMigrationManager class]);
    self.bundleMock = [OCMockObject mockForClass:[NSBundle class]];
    [[[self.bundleMock stub] andReturn:[NSBundle bundleForClass:[self class]]] mainBundle];
}

- (void)tearDown {
    self.applicationConfigurator = nil;
    self.fileManagerMock = nil;
    [self.magicalRecordMock stopMocking];
    self.magicalRecordMock = nil;
    [self.managedObjectModelClassMock stopMocking];
    self.managedObjectModelClassMock = nil;
    [self.migrationManager stopMocking];
    self.migrationManager = nil;
    [self.bundleMock stopMocking];
    self.bundleMock = nil;
    
    [super tearDown];
}

- (void)testSuccessSetupCoreDataStack {
    // given
    NSURL *url = [NSURL URLWithString:@"file:///Users/etrishina/Library/Developer/CoreSimulator/Devices/4A5D9B0C-6415-4788-80D3-3C0B9AC1BC2A/data/Containers/Shared/AppGroup/7FB5A35B-2398-4C72-BD06-49906AE490BA/"];
    OCMStub([self.fileManagerMock containerURLForSecurityApplicationGroupIdentifier:RCFAppGroupIdentifier]).andReturn(url);
    
    // when
    [self.applicationConfigurator setupCoreDataStack];
    
    // then
    OCMVerify([self.magicalRecordMock setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:url]);
}

@end
