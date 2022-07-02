//
//  ContentView.swift
//  ELevyGH
//
//  Created by Dave Agyakwa on 19/04/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("lastAmount") private var amount:String = ""
    @StateObject var calcService:ElevyCalcViewModel = ElevyCalcViewModel()
    var body: some View {
        NavigationView{
            VStack(alignment:.center){
                HStack {
                    VStack(alignment:.leading){
                        Label {
                            Text("ELevy Rate :")
                            Text(calcService.levyRate,format: .percent)
                            
                        } icon: {
                            Image(systemName: "banknote")
                                .foregroundColor(.green)
                        }
                        Label {
                            Text("Telcos Fee :")
                            Text(calcService.telcosCharge,format: .percent)
                        } icon: {
                            Image(systemName: "banknote")
                                .foregroundColor(.green)
                        }
                        Spacer()
                        Label {
                            Text("Charge of Telcos : ")
                            Text(calcService.telcosInterest,format: .currency(code: "ghs"))
                        } icon: {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                        }
                        Label {
                            Text("Charge of Telcos : ")
                            Text(calcService.withLevyInterest,format: .currency(code: "ghs"))
                        } icon: {
                            Image(systemName: "antenna.radiowaves.left.and.right")
                        }

                    }
                    Spacer()
                }
                .frame(height: 60)
                .padding(.horizontal,5)
                .padding(.bottom,50)
                
                
                HStack{
                    Image(systemName: "centsign.circle")
                        .font(.title)
                    Text("Total Amount : ")
                    Text(calcService.transactionAmount,format: .currency(code: "ghs"))
                }
                TextField("Money to send", text: $amount, prompt: Text("Enter amount you want to send "))
                    .keyboardType(.numberPad)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: amount) { newValue in
                        _ = calcService.calculateWithTelcos(for:Double(newValue) ?? 0)
                       _ = calcService.calculateWithLevy(for:Double(newValue) ?? 0)
                    }
                Button {
                    if let realAmount = Double(amount){
                        calcService.calculateTotal(for: realAmount)
                    }
                } label: {
                    Text("Calculate")
                    Image(systemName: "paperplane")
                        
                }.buttonStyle(.borderedProminent)

                Spacer()
                
            }.navigationTitle("E-levy")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
