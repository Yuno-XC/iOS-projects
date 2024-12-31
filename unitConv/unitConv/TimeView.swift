import SwiftUI

struct TimeView: View {
    @State var number = 0.0
    @State var timeFrom = "s"
    @State var timeTo = "min"
    @FocusState private var UnitOpen: Bool
    let inputTime = ["s", "min", "hr", "days", "wk"]
    let outputTime = ["s", "min", "hr", "days", "wk"]
    
    var timeConversion: Double {
        let secondsValue: Double
        switch timeFrom {
        case "s":
            secondsValue = number
        case "min":
            secondsValue = number * 60
        case "hr":
            secondsValue = number * 3600
        case "days":
            secondsValue = number * 86400
        case "wk":
            secondsValue = number * 604800
        default: fatalError("Unknown Time \(timeFrom)")
        }
        
        switch timeTo {
        case "s":
            return secondsValue
        case "min":
            return secondsValue / 60
        case "hr":
            return secondsValue / 3600
        case "days":
            return secondsValue / 86400
        case "wk":
            return secondsValue / 604800
        default: fatalError("Unknown Time \(timeTo)")
        }
    }
    
    var body: some View {
        Form {
            Section("Enter Time") {
                TextField("Enter Time", value: $number, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($UnitOpen)
            }
            Section("Convert Time From") {
                Picker("Input Time", selection: $timeFrom) {
                    ForEach(inputTime, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            Section("Convert Time To") {
                Picker("Output Time", selection: $timeTo) {
                    ForEach(outputTime, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            Section {
                Text("Converted Time:  \(timeConversion.formatted(.number.precision(.fractionLength(2)))) \(timeTo)")
            }
        }
        .navigationTitle("Time Converter")
        .toolbar {
            if UnitOpen {
                Button("Done") {
                    UnitOpen = false }
            }
        }
        .cornerRadius(10)
        .frame(height: 600)
    }
}

#Preview {
    TimeView()
}
