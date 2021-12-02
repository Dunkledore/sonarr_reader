import SwiftUI

struct SeriesFanartOverlayInfoWrapHStack: View {
    var pairs: [InfoPair] = []
    var body: some View {

            ForEach(self.pairs, id: \.self) { pair in
                SeriesFanartOverlayInfoView(icon: pair.icon, text: pair.text)
            }
    }
}

struct TestWrappedLayout_Previews: PreviewProvider {
    static var previews: some View {
            SeriesFanartOverlayInfoWrapHStack(pairs: [InfoPair(icon: "circle", text: "teseeeeet"),
                                  InfoPair(icon: "circle", text: "teeeeeeeeeeeeiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiieest"),
                                  InfoPair(icon: "circle", text: "test"),
                                  InfoPair(icon: "circle", text: "te   se   t"),
                                                      InfoPair(icon: "circle", text: "test")])
    }
}
