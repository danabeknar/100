//
//  ContentView.swift
//  Instafilter
//
//  Created by Beknar Danabek on 5.05.21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var showingImageErrorAlert = false
    @State private var processedImage: UIImage?
    @State private var changeFilterButtonTitle = "Change filter"
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                
                HStack {
                    Text("Radius")
                    Slider(value: radius)
                }
                
                HStack {
                    Button(changeFilterButtonTitle) {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            showingImageErrorAlert.toggle()
                            return
                        }

                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }

                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Instafilter")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"), buttons: [
                .default(Text("Crystallize")) {
                    self.changeFilterButtonTitle = "Crystallize"
                    self.setFilter(CIFilter.crystallize())
                },
                .default(Text("Edges")) {
                    self.changeFilterButtonTitle = "Edges"
                    self.setFilter(CIFilter.edges())
                },
                .default(Text("Gaussian Blur")) {
                    self.changeFilterButtonTitle = "Gaussian Blur"
                    self.setFilter(CIFilter.gaussianBlur())
                },
                .default(Text("Pixellate")) {
                    self.changeFilterButtonTitle = "Pixellate"
                    self.setFilter(CIFilter.pixellate())
                },
                .default(Text("Sepia Tone")) {
                    self.changeFilterButtonTitle = "Sepia Tone"
                    self.setFilter(CIFilter.sepiaTone())
                },
                .default(Text("Unsharp Mask")) {
                    self.changeFilterButtonTitle = "Unsharp Mask"
                    self.setFilter(CIFilter.unsharpMask())
                },
                .default(Text("Vignette")) {
                    self.changeFilterButtonTitle = "Vignette"
                    self.setFilter(CIFilter.vignette())
                },
                .cancel()
            ])
        }
        .alert(isPresented: $showingImageErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Couldn't save image"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
