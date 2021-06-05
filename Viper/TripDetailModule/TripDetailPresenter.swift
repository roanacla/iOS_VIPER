import SwiftUI
import Combine

class TripDetailPresennter: ObservableObject {
  @Published var tripName: String = "No name"
  @Published var distanceLabel: String = "Calculating..."
  @Published var waypoints: [Waypoint] = []
  
  private let router: TripDetailRouter
  let setTripName: Binding<String>
  
  private let interactor: TripDetailInteractor
  private var cancellable = Set<AnyCancellable>()
  init(interactor: TripDetailInteractor) {
    self.interactor = interactor
    self.router = TripDetailRouter(mapProvider: interactor.mapInfoProvider)
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
  
  func addWaypoint() {
    interactor.addWaypoint()
  }

  func didMoveWaypoint(fromOffsets: IndexSet, toOffset: Int) {
    interactor.moveWaypoint(fromOffsets: fromOffsets, toOffset: toOffset)
  }

  func didDeleteWaypoint(_ atOffsets: IndexSet) {
    interactor.deleteWaypoint(atOffsets: atOffsets)
  }

  func cell(for waypoint: Waypoint) -> some View {
    let destination = router.makeWaypointView(for: waypoint)
      .onDisappear(perform: interactor.updateWaypoints)
    return NavigationLink(destination: destination) {
      Text(waypoint.name)
    }
  }
}
