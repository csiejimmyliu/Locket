import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            } else {
                Text("Take a photo or upload")
                    .font(.headline)
            }

            HStack {
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text("Select Photo")
                }
                .padding()

                Button(action: sharePhoto) {
                    Text("Share with Friends")
                }
                .padding()
            }
        }
        .sheet(isPresented: $isImagePickerPresented, content: {
            ImagePicker(selectedImage: $selectedImage)
        })
    }

    func sharePhoto() {
        PhotoManager.shared.uploadPhoto(image: selectedImage)
        WidgetCenter.shared.reloadAllTimelines()  // Reload the widget's timeline
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
