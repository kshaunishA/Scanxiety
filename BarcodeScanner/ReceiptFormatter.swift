//
//  ReceiptFormatter.swift
//  BarcodeScanner
//
//  Created by Kshaunish Addala on 2025-07-29.
//

import Foundation

struct ReceiptFormatter {
    static func make(from info: ProductInfo) -> String {
        let date = DateFormatter.localizedString(
            from: .init(),
            dateStyle: .short, timeStyle: .short)
        
        let transactionId = String(format: "%06d", Int.random(in: 100000...999999))
        
        return """
        ╔══════════════════════════════════╗
        ║        SCANXIETY™ SCANNER        ║
        ║    Emotional Checkout System     ║
        ╚══════════════════════════════════╝
        
        Transaction ID: #\(transactionId)
        \(date)
        
        ────────────────────────────────────
        ITEM SCANNED:
        \(info.itemName)
        
        MONETARY COST: \(info.price)
        
        ────────────────────────────────────
        EMOTIONAL ANALYSIS:
        \(info.emotion)
        
        ────────────────────────────────────
        PSYCHOLOGICAL IMPACT: PROCESSED
        CONSUMER GUILT: CALCULATED
        VOID STATUS: UNFILLED
        
        ────────────────────────────────────
        
        * This receipt reflects the hidden
          emotional cost of your purchase
        
        * Feelings are non-refundable
        
        * For emotional support, please
          reconsider your life choices
        
        ────────────────────────────────────
        
        Thank you for your feelings.
        Your emotional transaction is complete.
        
        SCANXIETY™ - Exposing the true cost
        of everything since today.
        
        ═══════════════════════════════════
        """
    }
}
