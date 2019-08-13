//
//  UserSettings.swift
//  Note
//
//  Created by Pavel N on 8/6/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit

class UserSettings {
    var gitHubLoginedIn:Bool {
        return !self.gitHubToken.isEmpty
    }
    var gitHubToken:String = ""
    var gitHubGistID:String = ""
    let gitHubGistFileName = "ios-course-notes-db"
    let persistentContainerName = "NoteModel"
    let modelEntityName = "NoteObject"
    static let shared:UserSettings = UserSettings()
    
    //Private
    private init() {}
}
