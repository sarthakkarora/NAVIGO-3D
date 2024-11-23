//
//  ViewModel.swift
//  PersistenceAR
//
//  Created by Mohammad Azam on 6/14/22.
//

import Foundation

enum WorldMapStatus: String  {
    case notAvailable = "Not Available"
    case limited = "Limited"
    case extending = "Extending"
    case mapped = "Mapped"
}

class ViewModel: ObservableObject {
    var onSave: () -> Void = { }
    var onClear: () -> Void = { }
    @Published var isSaved: Bool = false
    @Published var worldMapStatus: WorldMapStatus = .notAvailable
}
