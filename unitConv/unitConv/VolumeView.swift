import SwiftUI

struct VolumeView: View {
    @State var number = 0.0
    @State var volumeFrom = "L"
    @State var volumeTo = "gal"
    @FocusState private var UnitOpen: Bool
    let inputVolume = ["L", "gal", "mL", "cup", "qt"]
    let outputVolume = ["L", "gal", "mL", "cup", "qt"]
    
    var volumeConversion: Double {
        let litersValue: Double
        switch volumeFrom {
        case "L":
            litersValue = number
        case "gal":
            litersValue = number * 3.78541
        case "mL":
            litersValue = number / 1000
        case "cup":
            litersValue = number * 0.236588
        case "qt":
            litersValue = number * 0.946353
        default: fatalError("Unknown Volume \(volumeFrom)")
        }
        
        switch volumeTo {
        case "L":
            return litersValue
        case "gal":
            return litersValue / 3.78541
        case "mL":
            return litersValue * 1000
        case "cup":
            return litersValue / 0.236588
        case "qt":
            return litersValue / 0.946353
        default: fatalError("Unknown Volume \(volumeTo)")
        }
    }
    
    var body: some View {
        Form {
            Section("Enter Volume") {
                TextField("Enter Volume", value: $number, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($UnitOpen)
                    
            }
            
            Section("Convert Volume From") {
                Picker("Input Volume", selection: $volumeFrom) {
                    ForEach(inputVolume, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Convert Volume To") {
                Picker("Output Volume", selection: $volumeTo) {
                    ForEach(outputVolume, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section {
                Text("Converted Volume:  \(volumeConversion.formatted(.number.precision(.fractionLength(2)))) \(volumeTo)") // Limit to 2 decimals
            }
        }
        .navigationTitle("Volume Converter")
        .toolbar {
            if UnitOpen {
                Button("Done") {
                    UnitOpen = false
                }
            }
        }
        .cornerRadius(10)
        .frame(height: 600)
    }
}

#Preview {
    VolumeView()
}
