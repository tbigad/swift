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
    
    enum Specialization:String {
        case Backend = "Backend", Frontent = "Frontent", Mobile = "Mobile", QA = "QA", Design = "Design", Support = "Support", Marketing = "Marketing", Sales = "Sales", none
    }
    
    enum Qualification:String {
        case intern = "Intern", junior = "Junior", middle = "Middle", senior = "Senior", lead = "Lead", none
    }
    
    enum JobStatus:String {
        case looking = "Looking", atWork = "At Work", notLooking = "Not Looking",notWork = "Not Work", none
    }
    
    func getBirthDateString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: self.birthDate)
    }
    
    @State var image:Image? = Image("defaultAvatar")
    
    //MARK:basic
    @State var name:String = ""
    @State var secondName:String = ""
    @State var email:String = ""
    @State var birthDate:Date = Date()
    @State var phoneNumber:String = ""
    @State var city:String = ""

    //MARK:about job information
    @State var specialization:Specialization = .none
    @State var qualification:Qualification = .none
    @State var status:JobStatus = .none
    @State var hoursOfWork:Int = 0
    @State var salary:Float = 0.0
    @State var workRemotely:Bool = false

    //MARK: additional
    @State var aboutMe:String = ""
    @State var photoData:Data = Data()
}
