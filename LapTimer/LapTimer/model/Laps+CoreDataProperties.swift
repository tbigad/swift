//
//  Laps+CoreDataProperties.swift
//  LapTimer
//
//  Created by Pavel N on 8/11/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//
//

import Foundation
import CoreData


extension Laps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Laps> {
        return NSFetchRequest<Laps>(entityName: "Laps")
    }

    @NSManaged public var time: Double

}
