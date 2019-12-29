//
//  DitailsView.swift
//  Profiles
//
//  Created by Pavel N on 12/29/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import SwiftUI

struct DitailsView: View {
    
    var item:Person
    var body: some View {
        List {
            GeneralInformationView(item: item)
            ContactInfo(item: item)
            JobInfo(item:item)
            Section(header: Text("About me")){
                Text(item.aboutMe)
            }
        }
    .navigationBarTitle("Details")
    }
}

struct DitailsView_Previews: PreviewProvider {
    static var previews: some View {
        DitailsView(item: testStore.items[0])
    }
}

struct GeneralInformationView: View {
    var item:Person
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: item.photo)!)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, idealWidth: 150, maxWidth: 150, minHeight: 0, idealHeight: 150, maxHeight: 150, alignment: .trailing)
            VStack(alignment: .leading){
                Text("\(item.name) \(item.secondName)")
                    .font(.title)
                Text("\(item.status.rawValue), \(item.qualification.rawValue), \(item.specialization.rawValue)")
                    .font(.body)
                Text(item.city)
                    .font(.body)
            }
        }
    }
}

struct ContactInfo: View {
    var item:Person
    var body: some View {
        Section(header: Text("Contact info")){
            Text(item.phoneNumber)
            Text(item.email)
            Text(item.getBirthDateString())
        }
    }
}

struct JobInfo: View {
    var item:Person
    var body: some View {
        Section(header: Text("Job info")){
            Text(String(item.hoursOfWork))
            Text(String(item.salary))
            Text(item.workRemotely ? "Yes" : "No")
        }
    }
}
