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


/*var testStore = PersonsStore(persons: [
    Person(name: "Petya", secondName: "Petrov", email: "Petya@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Backend, qualification: Person.Qualification.intern, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true, aboutMe: "Good boy", photoData: Data(UIImage(named: "defaultAvatar")!.pngData()!)),
    Person(name: "Vasya", secondName: "Vasiliev", email: "Vasya@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Design, qualification: Person.Qualification.intern, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true, aboutMe: "Good boy", photoData: Data(UIImage(named: "defaultAvatar")!.pngData()!)),
    Person(name: "Ivan", secondName: "Ivanov", email: "Ivan@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Frontent, qualification: Person.Qualification.intern, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true, aboutMe: "Good boy", photoData: Data(UIImage(named: "defaultAvatar")!.pngData()!)),
    Person(name: "Sergey", secondName: "Sergeev", email: "Sergey@tut.by", birthDate: Date(), phoneNumber: "111222333", city: "Minsk", specialization: Person.Specialization.Mobile, qualification: Person.Qualification.senior, status: Person.JobStatus.looking, hoursOfWork: 10, salary: 111.11, workRemotely: true,aboutMe: "Good boy", photoData: Data(UIImage(named: "defaultAvatar")!.pngData()!))] )*/
