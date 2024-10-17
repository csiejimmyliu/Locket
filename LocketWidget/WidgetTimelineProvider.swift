import WidgetKit
import SwiftUI

struct PhotoEntry: TimelineEntry {
    let date: Date
    let image: UIImage?
}

struct Provider: TimelineProvider {

    let appGroupID = "group.com.jimmy-test.shared"  // Replace with your actual App Group ID

    func placeholder(in context: Context) -> PhotoEntry {
        return PhotoEntry(date: Date(), image: UIImage(named: "placeholder"))
    }

    func getSnapshot(in context: Context, completion: @escaping (PhotoEntry) -> Void) {
        let entry = PhotoEntry(date: Date(), image: fetchLatestImage())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PhotoEntry>) -> Void) {
        let currentDate = Date()
        let refreshInterval = 15 * 60.0  // Refresh every 15 minutes

        let latestImage = fetchLatestImage()
        let entry = PhotoEntry(date: currentDate, image: latestImage)

        let nextUpdateDate = Calendar.current.date(byAdding: .second, value: Int(refreshInterval), to: currentDate)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))

        completion(timeline)
    }

    func fetchLatestImage() -> UIImage? {
        // Fetch the image from the shared App Group container
        if let sharedURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID)?.appendingPathComponent("sharedPhoto.jpg") {
            print("Trying to load image from: \(sharedURL.path)")  // Debugging: Print the path of the image
            if let imageData = try? Data(contentsOf: sharedURL),
               let image = UIImage(data: imageData) {
                print("Image loaded successfully from App Group")
                return image
            } else {
                print("Failed to load image from App Group")
            }
        } else {
            print("Could not get shared container URL")
        }
        return nil
    }
}
