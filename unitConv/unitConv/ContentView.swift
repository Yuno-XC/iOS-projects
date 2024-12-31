import SwiftUI

struct ContentView: View {
    
    let converter = ["Choose Category", "Temp🌡️", "Length📏", "Time⏱️", "Volume🥛"]
    @State private var baseConverter = ""
    @FocusState private var UnitOpen: Bool
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                VStack {
                    Picker("Converter", selection: $baseConverter) {
                        ForEach(converter, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(height: 150)
                    
                    // Display corresponding views based on the selection
                    if baseConverter == "Temp🌡️" {
                        TempView()
                            .padding(.top)
                    } else if baseConverter == "Length📏" {
                        LengthView()
                            .padding(.top)
                    } else if baseConverter == "Time⏱️" {
                        TimeView()
                            .padding(.top)
                    } else if baseConverter == "Volume🥛" {
                        VolumeView()
                            .padding(.top)
                    } else {
                        Text("Select a converter to begin")
                            .font(.headline)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Fixed credits overlay
                VStack {
                    Spacer()
                    VStack {
                        Text("Challa Somesh")
                            .font(.footnote)
                            .fontWeight(.light)
                        Text("Powered by SwiftUI")
                            .font(.footnote)
                            .fontWeight(.light)
                        Text("version 1.0")
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                    .padding(.bottom)
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if UnitOpen {
                    Button("Close") {
                        UnitOpen = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
