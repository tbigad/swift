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
    var person = Person()
    @State var aboutMeText:String = ""
    var body: some View {
        List {
            ImagePickerButton()
            BaseInfo(person: person)
            AboutJobInfo()
            VStack {
                Text("About me")
                TextField("About me", text: $aboutMeText)
                    .lineLimit(4)
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
    var person:Person
    var body: some View {
        Section(header: Text("Basic")) {
            HStack {
                TextField("Name", text: person.$name)
                TextField("SecondName", text: person.$secondName)
            }
            TextField("e-mail", text: person.$email)
            VStack{
                Text("Date of birthd")
                DatePicker(selection: person.$birthDate, displayedComponents: dateComponents, label: { Text("") })
            }
            
            TextField("Phone number", text: person.$phoneNumber)
            TextField("city", text: person.$city)
        }
    }
}

struct ImagePickerButton: View {
    @State var showImagePicker: Bool = false
    @State var image: Image = Image("defaultAvatar")
    
    var body: some View {
        HStack(alignment: .center) {
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
    @State var selectedQualification = "none"
    @State var selectedSpecialization = "none"
    @State var selectedJobStatus = "none"
    @State var hourInWeak:Int = 0
    @State var workRemote:Bool = false
    @State var someNumber = 123.0
    
    var salaryProxy: Binding<String> {
        Binding<String>(
            get: { String(format: "%.02f", Double(self.someNumber)) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.someNumber = value.doubleValue
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
