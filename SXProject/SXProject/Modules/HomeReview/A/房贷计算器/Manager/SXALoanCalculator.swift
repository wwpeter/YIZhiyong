//
//  SXALoanCalculator.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import Foundation


struct SXALoanCalculator {
    // MARK: - 等额本息（每月本金利息动态变化）
    static func equalInstallment(principal: Double, annualRate: Double, month: Int) -> [SXALoadPaymentDetailModel] {
        let months = month
        let monthlyRate = annualRate / 100 / 12
        let payment = equalInstallmentMonthlyPayment(principal: principal, monthlyRate: monthlyRate, months: months)
        
        var remainingPrincipal = principal
        var details = [SXALoadPaymentDetailModel]()
        
        for month in 1...months {
            let interest = remainingPrincipal * monthlyRate
            let principalInMonth = payment - interest
            remainingPrincipal -= principalInMonth
            
            // 处理最后一个月的小数点误差
            if month == months {
                remainingPrincipal = 0
            }
            
            details.append(SXALoadPaymentDetailModel(
                month: month,
                principal: round(principalInMonth * 100) / 100,
                interest: round(interest * 100) / 100,
                remaining: round(remainingPrincipal * 100) / 100
            ))
        }
        return details
    }
    
    // 等额本息每月还款额计算公式（复用原有逻辑）
    private static func equalInstallmentMonthlyPayment(principal: Double, monthlyRate: Double, months: Int) -> Double {
        let factor = pow(1 + monthlyRate, Double(months))
        return round((principal * monthlyRate * factor / (factor - 1)) * 100) / 100
    }
    
    // MARK: - 等本等息（每月本金利息固定）
    static func equalPrincipalInterest(principal: Double, annualRate: Double, months: Int) -> [SXALoadPaymentDetailModel] {
        let monthlyRate = annualRate / 100 / 12
        let principalPerMonth = principal / Double(months)
        let interestPerMonth = principal * monthlyRate
        
        return (1...months).map { month in
            SXALoadPaymentDetailModel(
                month: month,
                principal: round(principalPerMonth * 100) / 100,
                interest: round(interestPerMonth * 100) / 100,
                remaining: round(principal - principalPerMonth * Double(month) * 100) / 100
            )
        }
    }
    
    // MARK: - 等额本金（每月本金固定，利息递减）
    static func decreasingPayment(principal: Double, annualRate: Double, month: Int) -> [SXALoadPaymentDetailModel] {
        let months = month
        let monthlyRate = annualRate / 100 / 12
        let principalPerMonth = principal / Double(months)
        
        return (0..<months).map { month in
            let remainingBefore = principal - principalPerMonth * Double(month)
            let interest = remainingBefore * monthlyRate
            return SXALoadPaymentDetailModel(
                month: month + 1,
                principal: round(principalPerMonth * 100) / 100,
                interest: round(interest * 100) / 100,
                remaining: round(remainingBefore - principalPerMonth * 100) / 100
            )
        }
    }
    
    // MARK: - 先息后本（最后一个月还本金）
    static func interestFirst(principal: Double, annualRate: Double, months: Int) -> [SXALoadPaymentDetailModel] {
        let monthlyRate = annualRate / 100 / 12
        let monthlyInterest = principal * monthlyRate
        
        return (1...months).map { month in
            let isLastMonth = month == months
            return SXALoadPaymentDetailModel(
                month: month,
                principal: isLastMonth ? round(principal * 100) / 100 : 0,
                interest: round(monthlyInterest * 100) / 100,
                remaining: isLastMonth ? 0 : round(principal * 100) / 100
            )
        }
    }
}

