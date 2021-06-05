import Combine
import MapKit

class TripDetailInteractor {
  private let trip: Trip
  private let model: DataModel
  let mapInfoProvider: MapDataProvider
  
  private var cancellables = Set<AnyCancellable>()
  
  init(trip: Trip, model: DataModel, mapInfoProvider: MapDataProvider) {
    self.trip = trip
    self.mapInfoProvider = mapInfoProvider
    self.model = model
  }
  
}
