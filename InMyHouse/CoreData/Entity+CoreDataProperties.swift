//
//  Entity+CoreDataProperties.swift
//  SwiftUIVisionEmojiHunt
//
//  Created by Eric Rudenja on 26.04.2021.
//  Copyright © 2021 iowncode. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var highScore: Int16

}

extension Entity : Identifiable {

}
