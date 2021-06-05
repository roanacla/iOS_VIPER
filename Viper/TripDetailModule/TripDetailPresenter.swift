import SwiftUI
import Combine

class TripDetailPresennter: ObservableObject {
  @Published var tripName: String = "No name"
  let setTripName: Binding<String>
  
  private let interactor: TripDetailInteractor
  private var cancellable = Set<AnyCancellable>()
  init(interactor: TripDetailInteractor) {
    self.interactor = interactor
    
    setTripName = Binding<String>(
      get: { interactor.tripName },
      set: { interactor.setTripName($0) }
    )
        
    interactor.tripNamePublisher
      .assign(to: \.tripName, on: self)
      .store(in: &cancellable)
  }
  
  func save() {
    interactor.save()
  }
}
