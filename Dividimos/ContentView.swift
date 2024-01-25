//
//  ContentView.swift
//  Dividimos
//
//  Created by Lener Gonzalez on 20/1/24.
//

import SwiftUI

struct ContentView: View {
	
	@State var tipPercentage = 0
	@State var numberPeople = 1
	@State var total = "0"
	@State var taxPercentage = 0
	@State var calculate =  false
	
	let decimalChar = Character(Locale.current.decimalSeparator ?? ".")
	
	//Para encontrar si hay al menos 1 punto en la cadena total, si es asi returna false y no permite agregar otro punto y si es true entonces si permite agregar un punto
	var canAddDecimal: Bool {
		let periods = total.filter({$0 == "."})
		if periods.count == 0 {
			return true
		} else {
			return false
		}
	}
	
	var canAddDigit: Bool {
		guard let decIndex = total.firstIndex(of: ".") else { return true }
		let index = total.distance(from: total.startIndex, to: decIndex)
		return (total.count - index - 1 ) < 3
	}
	
	var body: some View {
		
		// MARK: Vista
		NavigationView {
			VStack {
				// MARK: Botones
				Text(total)
					.font(.system(size: 60, design: .rounded))
					.lineLimit(1)
					.minimumScaleFactor(0.5)
					.frame(width: 260, alignment: .trailing)
					.padding(.vertical, 1)
				
				HStack {
					ForEach(7...9, id: \.self) { number in numberButton(number: "\(number)")}
				}
				
				HStack {
					ForEach(4...6, id: \.self) { number in numberButton(number: "\(number)")}
				}
				
				HStack {
					ForEach(1...3, id: \.self) { number in numberButton(number: "\(number)")}
				}
				
				HStack {
					numberButton(number: "0")
					numberButton(number: String(decimalChar))
					
					
					Button{
						if total.count == 1 {
							total = "0"
						} else {
							total.removeLast()
						}
						
					} label: {
						Image(systemName: "delete.left.fill")
							.font(.largeTitle)
							.bold()
							.frame(width: 80, height: 80)
							.background(.gray)
							.foregroundColor(.white)
							.clipShape(Circle())
					}
				}
				
				VStack {
					
					
					Picker(selection: $taxPercentage, label: Text("")) {
						ForEach(0...100, id: \.self) { tax in
							Text("\(tax)% de Impuesto")
						}
					}
					.buttonStyle(.plain)
					
					Picker(selection: $tipPercentage, label: Text("")) {
						ForEach(0...100, id: \.self) { tip in
							Text("\(tip)% de Propina")
						}
					}
					.buttonStyle(.plain)
					
					Picker(selection: $numberPeople, label: Text("Propina")) {
						ForEach(0...100, id: \.self) { people in
							Text("\(people) personas")}
					}
					.buttonStyle(.plain)
					
				}
				.padding(30)
				
				HStack {
					Button("Calcular"){
						calculate = true
					}
					.disabled(Double(total) == 0)
					
					
					Button("Limpiar"){
						total = "0"
						taxPercentage = 0
						tipPercentage = 0
						numberPeople = 0
					}
				}
				.buttonStyle(.borderedProminent)
				
				Spacer()
			}
			.sheet(isPresented: $calculate) {
				TotalsView(total: Double(total) ?? 0, tipPercentage: tipPercentage, numberPeople: numberPeople, taxPercentage: taxPercentage)
					.presentationDetents([.large])

			}
			.navigationTitle("Dividimos")
			
		}
		
	}
	
	
	// MARK: Function
	func numberButton(number: String) -> some View {
		
		Button {
			addDigit(number)
		} label: {
			Text(number)
				.font(.system(size: 40, design: .rounded))
				.bold()
				.frame(width: 80, height: 80)
				.background(.green)
				.foregroundColor(.white)
				.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
		}
	
	}
	
	func addDigit(_ number: String) {
		if canAddDigit {
			if number == String(decimalChar){
				if canAddDecimal {
					total += number
				}
			} else {
				total = total == "0" ? number : total + number
			}
		}
	}
}

#Preview {
	ContentView()
}
