//
//  TotalsView.swift
//  Dividimos
//
//  Created by Lener Gonzalez on 20/1/24.
//

import SwiftUI

struct TotalsView: View {
	
	let total: Double
	let tipPercentage: Int
	let numberPeople: Int
	let taxPercentage: Int
	let identifier = Locale.current.currency?.identifier ?? ""
	
	var tipAmount: Double {
		total * Double(tipPercentage) / 100
	}
	
	var taxAmount: Double {
		total * Double(taxPercentage) / 100
	}
	
	var totalAmount: Double {
		total + tipAmount + taxAmount
	}
	
	var peoplePart: Double {
		totalAmount / Double(numberPeople)
	}
	
	
	var body: some View {
		
		NavigationStack {
			
			VStack{
				
				Grid {
					GridRow {
						Text("Cuenta")
							.font(.system(size: 30, design: .rounded))
							.bold()
							.gridColumnAlignment(.leading)
						Text("\(total, format: .currency(code: identifier))")
							.gridColumnAlignment(.trailing)
					}
					
					Text("Impuestos sobre Cuenta")
						.font(.system(size: 30, design: .rounded))
						.bold()
						.padding(.vertical, 25)
					
					Divider()
						.background(.red)
						.padding(.top, -30)
					
					GridRow {
						Text("Propina")
							.font(.system(size: 30, design: .rounded))
							.bold()
							.gridColumnAlignment(.leading)
						Text("\(tipAmount, format: .currency(code: identifier))")
							.gridColumnAlignment(.trailing)
					}
					
					GridRow {
						Text("Impuesto")
							.font(.system(size: 30, design: .rounded))
							.bold()
							.gridColumnAlignment(.leading)
						Text("\(taxAmount, format: .currency(code: identifier))")
							.gridColumnAlignment(.trailing)
					}
					
					
					Divider()
						.background(.blue)
					
					GridRow {
						Text("Total")
							.font(.system(size: 30, design: .rounded))
							.bold()
							.gridColumnAlignment(.leading)
						Text("\(totalAmount, format: .currency(code: identifier))")
							.gridColumnAlignment(.trailing)
					}
					
					Divider()
						.background(.blue)
						
					
					GridRow {
						Text("Por Persona")
							.font(.system(size: 30, design: .rounded))
							.bold()
						Text("\(peoplePart, format: .currency(code: identifier))")
							.gridColumnAlignment(.trailing)
					}
				}
				.font(.title)
				Spacer()
			}
			.padding(30)
			.navigationTitle("Totales")
		}
	}
}

#Preview {
	TotalsView(total: 1200.00, tipPercentage: 10, numberPeople: 5, taxPercentage: 15)
}
