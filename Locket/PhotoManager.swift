import Foundation
import UIKit

class PhotoManager: ObservableObject {
    static let shared = PhotoManager()

    let appGroupID = "group.com.jimmy-test.shared"  // Replace with your actual App Group ID

    // Resize the image to a maximum of 300x300 to fit widget constraints
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Determine the scale factor
        let scaleFactor = min(widthRatio, heightRatio)

        // Compute the new image size
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

        // Draw the resized image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? image
    }

    func uploadPhoto(image: UIImage?) {
        guard let image = image else { return }

        // Resize the image to fit within the widget's dimensions (300x300)
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 300, height: 300))

        if let imageData = resizedImage.jpegData(compressionQuality: 0.8) {
            // Save the image in the shared App Group container
            if let sharedURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID)?.appendingPathComponent("sharedPhoto.jpg") {
                do {
                    try imageData.write(to: sharedURL)
                    print("Resized image saved successfully at: \(sharedURL.path)")  // Debugging: Print the saved image path
                } catch {
                    print("Failed to save image: \(error.localizedDescription)")
                }
            } else {
                print("Could not get shared container URL")
            }
        }
    }
}
