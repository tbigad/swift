//
//  PersonModel.swift
//  Profiles
//
//  Created by Pavel N on 12/22/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import SwiftUI

final class Person : Identifiable {
    var id = UUID()
    
    enum Specialization:String,CaseIterable,Identifiable {
        var id: String { rawValue }
        case Backend = "Backend", Frontent = "Frontent", Mobile = "Mobile", QA = "QA", Design = "Design", Support = "Support", Marketing = "Marketing", Sales = "Sales", none
    }
    
    enum Qualification:String,CaseIterable,Identifiable {
        var id: String { rawValue }
        case intern = "Intern", junior = "Junior", middle = "Middle", senior = "Senior", lead = "Lead", none
    }
    
    enum JobStatus:String,CaseIterable,Identifiable {
        var id: String { rawValue }
        case looking = "Looking", atWork = "At Work", notLooking = "Not Looking",notWork = "Not Work", none
    }
    
    func getBirthDateString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: self.birthDate)
    }
    
    @State var image:Image = Image("defaultAvatar")
    
    //MARK:basic
    var name:String = ""
    var secondName:String = ""
    var email:String = ""
    var birthDate:Date = Date()
    var phoneNumber:String = ""
    var city:String = ""

    //MARK:about job information
    var specialization:Specialization = .none
    var qualification:Qualification = .none
    var status:JobStatus = .none
    var hoursOfWork:Int = 0
    var salary:Float = 0.0
    var workRemotely:Bool = false

    //MARK: additional
    var aboutMe:String = ""
    var photoData:Data = Data()
}
