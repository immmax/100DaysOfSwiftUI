//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Maxim Datskiy on 10/15/23.
//

import CoreLocation
import LocalAuthentication
import MapKit
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        var mapRegion = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
            )
        )
        
        private(set) var locations: [Location]
        var selectedPlace: Location?
        
        var isUnlocked = false
        var showingFaceIDAlert = false
        var showingNonBiometricsAuthenticateMethod = false
        var username = ""
        var password = ""
        
        var isStandardMapMode = true
        
        var isValidLoginData: Bool {
            username == "" && password == ""
        }
        
        var mapStyle: MapStyle {
            isStandardMapMode ? .standard : .hybrid(elevation: .realistic)
        }
        
//        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            // Loading saved locations
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
//             Create a new location
            let newLocation = Location(id: UUID(),
                                       name: "New location",
                                       description: "",
                                       latitude: point.latitude,
                                       longitude: point.longitude  )
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showingFaceIDAlert = true
                    }
                }
            } else {
                // no biometrics
                self.showingNonBiometricsAuthenticateMethod = true
            }
        }
    }
}
