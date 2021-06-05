import SwiftUI

class TripListRouter {
  func makeDetailView(for trip: Trip, model: DataModel) -> some View {
    let interactor = TripDetailInteractor(trip: trip, model: model, mapInfoProvider: RealMapDataProvider())
    let presenter = TripDetailPresennter(interactor: interactor)
    return TripDetailView(presenter: presenter)
  }
}
