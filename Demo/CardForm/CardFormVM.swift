////
////  CardFormVM.swift
////  Demo
////
////  Created by Kerollos Nabil on 10/11/2024.
////
//
import SwiftUI
import MoneyHash
import SwiftUI

class CardFormVM: ObservableObject {
    var id: String {
        UUID().uuidString
    }
    
    @Published var cardState: CardInputFieldState = .defaultState
    @Published var cvvState: CardInputFieldState = .defaultState
    @Published var holderNameState: CardInputFieldState = .defaultState
    @Published var expireMonthState: CardInputFieldState = .defaultState
    @Published var expireYearState: CardInputFieldState = .defaultState
    @Published var cardImageURL: URL? = nil
    
    @FocusState var focusedField: Field?

    enum Field {
        case cardNumber, cvv, cardHolderName, expireMonth, expireYear
    }
    
    private(set) var cardForm: CardForm!
    
    init(){
        setupCardCollector()
    }
  
    private func setupCardCollector() {
        
        self.cardForm = CardFormBuilder()
            .setCardNumberField(handler: updateCardState)
            .setCVVField(handler: updateCVVState)
            .setCardHolderNameField(handler: updateHolderNameState)
            .setExpireMonthField(handler: updateExpireMonthState)
            .setExpireYearField(handler: updateExpireYearState)
            .setCardBrandChangeHandler(updateCardBrand)
            .build()
        
    }
    
    private func updateCardState(_ state: CardInputFieldState) {
        DispatchQueue.main.async {
            self.cardState = state
            if state.isValid ?? false  && state.inputLength == 16 {
                self.focusedField = .cvv
                
            }
        }    }
    
    private func updateCVVState(_ state: CardInputFieldState) {
        self.cvvState = state
    }
    
    private func updateHolderNameState(_ state: CardInputFieldState) {
        self.holderNameState = state
    }
    
    private func updateExpireMonthState(_ state: CardInputFieldState) {
        self.expireMonthState = state
    }
    
    private func updateExpireYearState(_ state: CardInputFieldState) {
        self.expireYearState = state
    }
    
    private func updateCardBrand(_ brand: CardBrand) {
        self.cardImageURL = URL(string: brand.brandIconUrl)
    }
    
    
    func submitTokensAndGetVaultData() async throws -> VaultData? {
        return try await cardForm.collect()
    }
    
    var view: AnyView {
        AnyView(CardFormView(cardFormVM: self))
    }
    
    var isValid: Bool {
        cardForm.isValid
    }
    
    func submit() {
        Task {
            try await cardForm.collect()
        }
    }
}
