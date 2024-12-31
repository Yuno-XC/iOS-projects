import SwiftUI

struct TempView: View {
    @State var number = 0.0
    @State var UnitTemperature = "C"
    @State var UnitTemperature1 = "F"
    @FocusState private var UnitOpen: Bool
    let inputTemp = ["C", "F", "K"]
    let outputTemp = ["C", "F", "K"]
    
    var temperatureConversion: Double {
        let celciusValue: Double
        switch UnitTemperature {
        case "C":
            celciusValue = number
        case "F":
            celciusValue = (number - 32) * 5/9  // Convert fahrenheit to celcius first for correct calculation
        case "K":
            celciusValue = number - 273.15  // Convert kelvin to celcius first for correct calculation
        default:
            fatalError("Unknown temperature unit")
        }
        switch UnitTemperature1 {
        case "C":
            return celciusValue
        case "F":
            return (celciusValue * 9/5) + 32
        case "K":
            return celciusValue + 273.15
        default:
            fatalError("Unknown temperature unit")
        }
    }
    
    var body: some View {
        
        Form {
            
            Section("Enter a number") {
                TextField("Enter number", value: $number, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($UnitOpen)
            }
            Section("Choose temp unit") {
                Picker("Choose temp unit", selection: $UnitTemperature) {
                    ForEach(inputTemp, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.segmented)
            
            Section("Convert to which temp unit") {
                Picker("Convert to", selection: $UnitTemperature1) {
                    ForEach(outputTemp, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.segmented)
            
            Section {
                Text("Converted value:  \(temperatureConversion.formatted(.number.precision(.fractionLength(2)))) \(UnitTemperature1)") // Limit to 2 decimals
            }
        }
        //.padding(.vertical)
        //.frame(width: .infinity, height: 500)
        
        
        .navigationTitle("Temperature Converter")
        
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
    TempView()
}


