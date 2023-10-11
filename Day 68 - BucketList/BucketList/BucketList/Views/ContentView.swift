//
//  ContentView.swift
//  BucketList
//
//  Created by Maxim Datskiy on 9/20/23.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var locations = [Location]()
    
    @State private var isUnlocked = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude,
                                                             longitude: location.longitude))
            }
                .ignoresSafeArea()
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        //create a new location
                        let newLocation = Location(id: UUID(),
                                                   name: "New location",
                                                   description: "",
                                                   latitude: mapRegion.center.latitude,
                                                   longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding(.horizontal)
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        
        
        
//        VStack {
//            if isUnlocked {
//                Text("Unlocked")
//            } else {
//                Text("Locked")
//            }
//            Button("Use Face ID to Unlock", action: authenticate)
//                .buttonStyle(.borderedProminent)
//                .padding()
//            Button() {
//                isUnlocked = false
//            } label: {
//                Image(systemName: "lock.fill")
//            }
//                .tint(.red)
//                .padding()
//        }
////        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, autenticationError in
                if success {
                    // authenticated succesfully
                    isUnlocked = true
                } else {
                    // there was a problem
                    
                }
            }
        } else {
            // no biometrics
            
        }
    }
}

#Preview {
    ContentView()
}
