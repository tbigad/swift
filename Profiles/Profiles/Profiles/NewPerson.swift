//
//  NewPerson.swift
//  Profiles
//
//  Created by Pavel Nadolski on 1/3/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

import SwiftUI

struct NewPerson: View {

    var dateComponents:DatePicker.Components = [.date]
    @EnvironmentObject var store:PersonsStore
    var person = Person()
    var body: some View {
        List {
            HStack {
                TextField("Name", text: person.$name)
                TextField("SecondName", text: person.$secondName)
            }
            TextField("e-mail", text: person.$email)
            TextField("Phone number", text: person.$phoneNumber)
            TextField("city", text: person.$city)
            DatePicker(selection: person.$birthDate, displayedComponents: dateComponents, label: { Text("") })
            
        }
    }
}

struct NewPerson_Previews: PreviewProvider {
    static var previews: some View {
        NewPerson()
    }
}
