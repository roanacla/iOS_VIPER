import SwiftUI

struct TripDetailView: View {
  @ObservedObject var presenter: TripDetailPresennter
  
    var body: some View {
      VStack {
        TextField("Trip Name", text: presenter.setTripName)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding([.horizontal])
      }
      .navigationBarTitle(Text(presenter.tripName), displayMode: .inline)
      .navigationBarItems(trailing: Button("Save", action: presenter.save))
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
      let model = DataModel.sample
      let trip = model.trips[1]
      let mapProvider = RealMapDataProvider()
      let interactor = TripDetailInteractor(trip: trip,
                                            model: model,
                                            mapInfoProvider: mapProvider)
      let presenter = TripDetailPresennter(interactor: interactor)
      return NavigationView { TripDetailView(presenter: presenter) }
    }
}
