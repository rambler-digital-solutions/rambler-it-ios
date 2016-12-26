//
//  TVLectureListModuleTVLectureListModuleViewOutput.h
//  Conferences
//
//  Created by Porokhov Artem on 21/12/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TVLectureListModuleViewOutput <NSObject>

/**
 @author Porokhov Artem

 Метод сообщает презентеру о том, что view готова к работе
 */
- (void)didTriggerViewReadyEvent;

@end
