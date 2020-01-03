//
//  NewPerson.swift
//  Profiles
//
//  Created by Pavel Nadolski on 1/3/20.
//  Copyright © 2020 Pavel N. All rights reserved.
//

import SwiftUI

struct NewPerson: View {
    @State var str:String = ""
    @State var textVisible = true
    
    var person = Person()
    var body: some View {
        VStack {
            if textVisible {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            TextField("Name", text: $str)
        }
    }
}

struct NewPerson_Previews: PreviewProvider {
    static var previews: some View {
        NewPerson()
    }
}
