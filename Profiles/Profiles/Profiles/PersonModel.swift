//
//  PersonModel.swift
//  Profiles
//
//  Created by Pavel N on 12/22/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import Foundation

struct Person : Identifiable {
    var id = UUID()
    
    enum Specialization:String {
        case Backend = "Backend", Frontent = "Frontent", Mobile = "Mobile", QA = "QA", Design = "Design", Support = "Support", Marketing = "Marketing", Sales = "Sales"
    }
    
    enum Qualification:String {
        case intern = "Intern", junior = "Junior", middle = "Middle", senior = "Senior", lead = "Lead"
    }
    
    enum JobStatus:String {
        case looking = "Looking", atWork = "At Work", notLooking = "Not Looking",notWork = "Not Work"
    }
    
    func getBirthDateString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: self.birthDate)
    }
    
    //MARK:basic
    let name:String
    let secondName:String
    let email:String
    let birthDate:Date
    let phoneNumber:String
    let city:String

    //MARK:about job information
    let specialization:Specialization
    let qualification:Qualification
    let status:JobStatus
    let hoursOfWork:Int
    let salary:Float
    let workRemotely:Bool

    //MARK: additional
    let photo:Data
    let aboutMe:String
}
