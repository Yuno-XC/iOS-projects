import SwiftUI

struct LengthView: View {
    @State var number = 0.0
    @State var Length = "m"
    @State var Length1 = "km"
    @FocusState private var UnitOpen: Bool
    let inputLength = ["m", "km", "ft", "yd", "mi"]
    let outputLength = ["m", "km", "ft", "yd", "mi"]
    
    var lengthConversion: Double {
        let metersValue: Double
        
        switch Length {
        case "m":
            metersValue = number
        case "km":
            metersValue = number * 1000
        case "ft":
            metersValue = number * 0.3048
        case "yd":
            metersValue = number * 0.9144
        case "mi":
            metersValue = number * 1609.34
        default:
            fatalError("Unknown Length unit: \(Length)")
        }
        
        switch Length1 {
        case "m":
            return metersValue
        case "km":
            return metersValue / 1000
        case "ft":
            return metersValue / 0.3048
        case "yd":
            return metersValue / 0.9144
        case "mi":
            return metersValue / 1609.34
        default:
            fatalError("Unknown Length unit: \(Length1)")
        }
    }
    
    var body: some View {
        Form {
            Section("Enter Length") {
                TextField("Enter Length", value: $number, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($UnitOpen)
                    
                    
            }
            
            Section("Convert Length From") {
                Picker("Input length", selection: $Length) {
                    ForEach(inputLength, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Convert Length To") {
                Picker("Output length", selection: $Length1) {
                    ForEach(outputLength, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section {
                Text("Converted Length:  \(lengthConversion.formatted(.number.precision(.fractionLength(2)))) \(Length1)") // Limit to 2 decimals
            }
        }
        .navigationTitle("Length Converter")
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
    LengthView()
}
