import SwiftUI
import Combine

class TripDetailPresennter: ObservableObject {
  @Published var tripName: String = "No name"
  @Published var distanceLabel: String = "Calculating..."
  @Published var waypoints: [Waypoint] = []
  
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
    
    interactor.$totalDistance
      .map { "Total Distance: " + MeasurementFormatter().string(from: $0)}
      .replaceNil(with: "Calculating...")
      .assign(to: \.distanceLabel, on: self)
      .store(in: &cancellable)
    
    interactor.$waypoints
      .assign(to: \.waypoints, on: self)
      .store(in: &cancellable)
  }
  
  func makeMapView() -> some View {
    TripMapView(presenter: TripMapViewPresenter(interactor: interactor ))
  }
  
  func save() {
    interactor.save()
  }
}
