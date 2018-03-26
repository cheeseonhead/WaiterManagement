//
//  Waiter+CoreDataProperties.h
//  StaffManagement
//
//  Created by Jeffrey Wu on 2018-03-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Restaurant, Shift;

NS_ASSUME_NONNULL_BEGIN

@interface Waiter : NSManagedObject

@end

@interface Waiter (CoreDataProperties)

+ (NSFetchRequest<Waiter *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Restaurant *restaurant;
@property (nullable, nonatomic, retain) NSSet<Shift *> *shift;

@end

@interface Waiter (CoreDataGeneratedAccessors)

- (void)addShiftObject:(Shift *)value;
- (void)removeShiftObject:(Shift *)value;
- (void)addShift:(NSSet<Shift *> *)values;
- (void)removeShift:(NSSet<Shift *> *)values;

@end

NS_ASSUME_NONNULL_END
