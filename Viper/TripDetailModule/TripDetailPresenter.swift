import SwiftUI
import Combine

class TripDetailPresennter: ObservableObject {
  private let interactor: TripDetailInteractor
  private var cancellable = Set<AnyCancellable>()
  init(interactor: TripDetailInteractor) {
    self.interactor = interactor
  }
}
