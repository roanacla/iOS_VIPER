import Combine
import MapKit

class TripDetailInteractor {
  private let trip: Trip
  private let model: DataModel
  let mapInfoProvider: MapDataProvider
  var tripName: String { trip.name }
  var tripNamePublisher: Published<String>.Publisher { trip.$name }
  
  private var cancellables = Set<AnyCancellable>()
  
  init(trip: Trip, model: DataModel, mapInfoProvider: MapDataProvider) {
    self.trip = trip
    self.mapInfoProvider = mapInfoProvider
    self.model = model
  }
  
  func setTripName(_ name: String) {
    trip.name = name
  }
  
  func save() {
    model.save()
  }
  
}
