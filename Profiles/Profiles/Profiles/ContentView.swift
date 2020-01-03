//
//  ContentView.swift
//  Profiles
//
//  Created by Pavel N on 12/22/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = testStore
    
    var body: some View {
        NavigationView {
            List{
                ForEach(store.items) { item in
                    NavigationLink(destination: DitailsView(item: item), label:{PersonCell(item: item)})
                }
            }
            .navigationBarTitle("People")
            .navigationBarItems(trailing:NavigationLink(destination: NewPerson(), label: {
                Image(systemName: "plus")
                Text("Add")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PersonCell: View {
    var item:Person
    var body: some View {
        HStack {
            item.image.resizable().frame(width: 50, height: 50).clipShape(Circle())
            VStack(alignment: .leading) {
                Text("\(item.name) \(item.secondName)")
                Text("\(item.status.rawValue), \(item.qualification.rawValue), \(item.specialization.rawValue)")
            }
        }
    }
}
