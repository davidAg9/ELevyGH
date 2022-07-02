//
//  ELevyFeeService.swift
//  ELevyGH
//
//  Created by Dave Agyakwa on 19/04/2022.
//

import Foundation


final class ElevyCalcViewModel: ObservableObject{
    let telcosCharge:Double = 0.01
    let levyRate:Double  = 0.015
    @Published private(set)var telcosInterest:Double = 0
    @Published private(set) var withLevyInterest:Double = 0.0
    @Published private(set) var  transactionAmount:Double = 0.0
    
    
    func calculateWithLevy(for amount:Double) -> Double {
       withLevyInterest =  amount * levyRate
        return withLevyInterest
    }
    
    func calculateWithTelcos(for amount:Double) -> Double {
        telcosInterest = amount * telcosCharge
        return telcosInterest
    }
    func withLevyAndTecos(for amount:Double) -> Double {
      let totalTransactionCharge = calculateWithLevy(for: amount) + calculateWithTelcos(for: amount)
        return totalTransactionCharge
    }
    
    func calculateTotal(for amount:Double)  {
       let charge = withLevyAndTecos(for: amount)
        transactionAmount = charge + amount
    }
    
}

