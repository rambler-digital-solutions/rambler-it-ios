//
//  LectureMaterialType.h
//  Conferences
//
//  Created by Egor Tolstoy on 12/08/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#ifndef LectureMaterialType_h
#define LectureMaterialType_h

/**
 @author Egor Tolstoy
 
 Lecture materials types
 */
typedef NS_ENUM(NSUInteger, LectureMaterialType) {
    /**
     @author Egor Tolstoy
     
     Video recording
     */
    LectureMaterialVideoType = 0,
    /**
     @author Egor Tolstoy
     
     Slides
     */
    LectureMaterialPresentationType = 1,
    /**
     @author Egor Tolstoy
     
     Source code
     */
    LectureMaterialRepoType = 2,
    /**
     @author Egor Tolstoy
     
     Article
     */
    LectureMaterialArticleType = 3,
    /**
     @author Egor Tolstoy
     
     Other
     */
    LectureMaterialOtherType = 4
};

#endif /* LectureMaterialType_h */
