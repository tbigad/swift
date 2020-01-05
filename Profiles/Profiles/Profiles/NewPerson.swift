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
    var person = Person()
    var body: some View {
        List {
            //BaseInfo(person: person)
            Divider()
            ImagePickerButton()
            
        }
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
