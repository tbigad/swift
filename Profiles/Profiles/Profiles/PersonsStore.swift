//
//  PersonsStore.swift
//  Profiles
//
//  Created by Pavel N on 12/25/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import SwiftUI
import Combine

class PersonsStore: ObservableObject {
    var items:[Person] {
        didSet {
            objectWillChange.send()
        }
    }
    
    init(persons: [Person] = []) {
        items = persons
    }
    
    var objectWillChange = PassthroughSubject<Void,Never>()
}


var testStore = PersonsStore(persons: [Person(name: "Petya", secondName: "petrov", email: "Petya@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Backend, qualification: Person.Qualification.intern, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true, photo: Data(UIImage(named: "defaultAvatar")!.pngData()!), aboutMe: "Good boy"), Person(name: "Vasya", secondName: "Vasiliev", email: "Petya@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Backend, qualification: Person.Qualification.intern, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true, photo: Data(UIImage(named: "defaultAvatar")!.pngData()!), aboutMe: "Good boy"), Person(name: "Petya", secondName: "petrov", email: "Petya@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Backend, qualification: Person.Qualification.intern, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true, photo: Data(UIImage(named: "defaultAvatar")!.pngData()!), aboutMe: "Good boy"), Person(name: "Petya", secondName: "petrov", email: "Petya@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Backend, qualification: Person.Qualification.intern, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true, photo: Data(), aboutMe: "Good boy")] )
