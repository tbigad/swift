//
//  NewPerson.swift
//  Profiles
//
//  Created by Pavel Nadolski on 1/3/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

import SwiftUI

struct NewPerson: View {
    @EnvironmentObject var store:PersonsStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name:String = ""
    @State var secondName:String = ""
    @State var email:String = ""
    @State var phoneNumber:String = ""
    @State var city:String = ""
    @State var birthDate:Date = Date()
    @State var aboutMeText:String = ""
    
    @State var selectedQualification:String = "none"
    @State var selectedSpecialization:String = "none"
    @State var selectedJobStatus:String = "none"
    @State var hourInWeak:Int = 0
    @State var workRemote:Bool = false
    @State var salary:Float = 123.0
    
    @State var image = Image("defaultAvatar")
    
    var body: some View {
        List {
            ImagePickerButton(image: $image)
            BaseInfo(name: $name, secondName: $secondName, email: $email, phoneNumber: $phoneNumber, city: $city, birthDate: $birthDate)
            AboutJobInfo(selectedQualification: $selectedQualification, selectedSpecialization: $selectedSpecialization, selectedJobStatus: $selectedJobStatus, hourInWeak: $hourInWeak, workRemote: $workRemote, salaryNumber: $salary)
            VStack {
                Text("About me")
                TextField("About me", text: $aboutMeText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button(action: {
                self.saveAndPop()
            }) {
                Text("Save")
            }.buttonStyle(BorderlessButtonStyle())
        }
        
    }
    
    func saveAndPop(){
        let person = Person()
        person.image = self.image
        person.name = self.name
        person.secondName = self.secondName
        person.email = self.email
        person.phoneNumber = self.phoneNumber
        person.city = self.city
        person.birthDate = self.birthDate
        person.aboutMe = self.aboutMeText
        person.qualification = Person.Qualification(rawValue: self.selectedQualification)!
        person.specialization = Person.Specialization(rawValue: self.selectedSpecialization)!
        person.status = Person.JobStatus(rawValue:self.selectedJobStatus)!
        person.hoursOfWork = self.hourInWeak
        person.workRemotely = self.workRemote
        person.salary = self.salary
        store.items.append(person)
        presentationMode.wrappedValue.dismiss()
    }
}

struct NewPerson_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewPerson()
                .navigationBarTitle("Add new",displayMode:.inline)
        }
    }
}

struct BaseInfo: View {
    var dateComponents:DatePicker.Components = [.date]
    
    @Binding var name:String
    @Binding var secondName:String
    @Binding var email:String
    @Binding var phoneNumber:String
    @Binding var city:String
    @Binding var birthDate:Date
    
    var body: some View {
        Section(header: Text("Basic")) {
            HStack {
                TextField("Name", text: $name)
                TextField("SecondName", text: $secondName)
            }
            TextField("e-mail", text: $email)
            VStack{
                Text("Date of birthd")
                DatePicker(selection: $birthDate, displayedComponents: dateComponents, label: { Text("") })
            }
            
            TextField("Phone number", text: $phoneNumber)
            TextField("city", text: $city)
        }
    }
}

struct ImagePickerButton: View {
    @State var showImagePicker: Bool = false
    @Binding var image: Image
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    withAnimation {
                        self.showImagePicker.toggle()
                    }
                }) {
                    Text("Add new image")
                }
                
                image.resizable().frame(width: 100, height: 100)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$image)
            }
        }
    }
}

struct AboutJobInfo: View {
    @Binding var selectedQualification:String
    @Binding var selectedSpecialization:String
    @Binding var selectedJobStatus:String
    @Binding var hourInWeak:Int
    @Binding var workRemote:Bool
    @Binding var salaryNumber:Float
    
    var salaryProxy: Binding<String> {
        Binding<String>(
            get: { String(format: "%.02f", Float(self.salaryNumber)) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.salaryNumber = value.floatValue
                }
        }
        )
    }
    
    var body: some View {
        VStack {
                Picker(selection: $selectedQualification, label: Text("Qualification")) {
                    ForEach(Person.Qualification.allCases) { item in
                        Text(item.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Picker(selection: $selectedSpecialization, label: Text("Specialization")) {
                    ForEach(Person.Specialization.allCases) { item in
                        Text(item.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Picker(selection: $selectedJobStatus, label: Text("Job Status")) {
                    ForEach(Person.JobStatus.allCases) { item in
                        Text(item.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            
            Stepper(value: self.$hourInWeak, in: 0...16) {
                Text("Hour in week \(hourInWeak)")
            }
            HStack {
                Text("Salary ")
                TextField("Salary", text: salaryProxy)
            }
            Toggle(isOn: $workRemote) {
                Text("Work remotely")
            }
        }
    }
}
