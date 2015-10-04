//
//  CompoundOperationQueueOutput.h
//  LiveJournal
//
//  Created by Egor Tolstoy on 01/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @author Egor Tolstoy
 
 Протокол, которым закрывается объект, способный обработать выходные данные, получившиеся в результате работы очереди операций
 */
@protocol CompoundOperationQueueOutput <NSObject>

/**
 @author Egor Tolstoy
 
 Метод устанавливает данные, которые будут переданы compound-операцией как результат ее выполнения
 */
- (id)obtainOperationQueueOutputData;

@end
