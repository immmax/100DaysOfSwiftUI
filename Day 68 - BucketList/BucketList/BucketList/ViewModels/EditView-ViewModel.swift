//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Maxim Datskiy on 10/15/23.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var loadingState = LoadingState.loading
        @Published var name: String = ""
        @Published var description: String = ""
    }
}
