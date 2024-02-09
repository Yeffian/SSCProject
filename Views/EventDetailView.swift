//
//  EventDetailView.swift
//
//
//  Created by Adit Chakraborty on 13/01/2024.
//

import SwiftUI

struct EventDetailView: View {
    @State var event: Event
    
    @State private var isShowingCareeSettingsView = false
    @EnvironmentObject private var careeInformation: ApplicationSettings
    
    @State var careeName = ""
    @State var useIcons: Bool = false

    
    var body: some View {
        List {
            Section(header: Text("Information")) {
                HStack {
                    Text("Location")
                    Spacer()
                    Text(event.location)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Time")
                    Spacer()
                    Text(event.date, format: .dateTime.hour().minute())
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Task")
                    Spacer()
                    Text(event.remainder)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Status")
                    Spacer()
                    Text(event.getEventStatus())
                }
                
                
                 // TODO: Add contacts and contact view
            }
            
            if !event.notes.isEmpty {
                Section(header: Text("Notes")) {
                    ForEach(event.notes, id: \.self) { note in
                        Text(note)
                    }
                }
            } 
            
            Section(header: Text("Images")) {
                if (event.referenceImages.count > 0) {
                    TabView {
                        ForEach(event.referenceImages, id: \.self) { referenceImage in
                            Image(uiImage: UIImage(data: referenceImage!)!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 520)
                } else {
                    Text("No images.")
                }
            }
        }
        .navigationTitle(event.eventName)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    isShowingCareeSettingsView.toggle()
                } label: {
                    if careeInformation.useIcons! {
                        Image(systemName: "gear")
                    } else {
                        Text("Settings")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingCareeSettingsView, content: {
            NavigationView {
                Form {
                    Section("Caree Details") {
                        TextField("What is the name of the caree?", text: $careeName)
                    }
                    
                    Section("Application Settings") {
                        Toggle("Use icons instead of text for certain buttons", isOn: $useIcons)
                    }
                }
                .navigationTitle("Caree Information")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Update", action: {
                            Task {
                                careeInformation.careeName = careeName
                                careeInformation.useIcons = useIcons
                                
                                UserDefaults.standard.set(careeInformation.careeName, forKey: "CareeInformation_Name")
                                UserDefaults.standard.set(careeInformation.useIcons, forKey: "ApplicationSettings_UseIcons")
                                isShowingCareeSettingsView.toggle()
                            }
                        })
                    }
                    
                    ToolbarItemGroup(placement: .cancellationAction) {
                        Button("Cancel", action: {
                            isShowingCareeSettingsView.toggle()
                        })
                    }
                }
                .task {
                    careeInformation.careeName = UserDefaults.standard.string(forKey: "CareeInformation_Name")
                    careeInformation.useIcons = UserDefaults.standard.bool(forKey: "ApplicationSettings_UseIcons")
                }
            }
        })
    }
}


