import WidgetKit
import SwiftUI

struct PhotoWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        if let image = entry.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Text("No photo yet")
        }
    }
}

@main
struct PhotoWidget: Widget {
    let kind: String = "PhotoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PhotoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Live Photo Widget")
        .description("Displays the latest photo shared by your friends.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
