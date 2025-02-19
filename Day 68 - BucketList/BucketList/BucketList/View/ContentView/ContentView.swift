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
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            GeometryReader { geometry in
                MapReader { proxy in
                    Map(position: $viewModel.mapRegion) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .simultaneousGesture(
                                        LongPressGesture().onEnded { _ in
                                            viewModel.selectedPlace = location
                                        }
                                    )
                            }
    //                            .annotationTitles(.hidden)
                        }
                    }
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                    .mapStyle(viewModel.mapStyle)
                    .mapControls {
                        MapUserLocationButton()
                        MapPitchToggle()
                    }
                    .overlay(alignment: .bottomTrailing) {
                        HStack {
                            Toggle("Map Style", isOn: $viewModel.isStandardMapMode)
                                .padding()
                            
                            Button {
                                let centerPoint = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
                                print(centerPoint)
                                if let coordinate = proxy.convert(centerPoint, from: .local) {
                                    viewModel.addLocation(at: coordinate)
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                    }
                    .overlay {
                        Circle()
                            .fill(.blue)
                            .opacity(0.3)
                            .frame(width: 32, height: 32)
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .alert("Unable to unlock using FaceID", isPresented: $viewModel.showingFaceIDAlert) {
                    Button("Login with username and password") {
                        viewModel.showingNonBiometricsAuthenticateMethod = true
                    }
                }
                .sheet(isPresented: $viewModel.showingNonBiometricsAuthenticateMethod) {
                    Form {
                        TextField("Username", text: $viewModel.username)
                            .textInputAutocapitalization(.never)
                            .padding()
                        SecureField("Password", text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                            .padding()
                        HStack {
                            Spacer()
                            Button("Login") {
                                if viewModel.isValidLoginData {
                                    viewModel.isUnlocked = true
                                }
                            }
                            .padding()
                            .buttonStyle(.borderedProminent)
                            Spacer()
                        }
                    }
                    .navigationTitle("Login")
                    .navigationBarTitleDisplayMode(.inline)
                }
        }
    }
}

#Preview {
    ContentView()
}
