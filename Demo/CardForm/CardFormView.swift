//
//  PaymentForm.swift
//  Demo
//
//  Created by Kerollos Nabil on 10/06/2024.
//

import SwiftUI
import MoneyHash

struct CardFormView: View {
    
    @ObservedObject var cardFormVM: CardFormVM
    
    // Focus states for each input field
    @FocusState private var focusedField: Field?

    enum Field {
        case cardNumber, cvv, cardHolderName, expireMonth, expireYear
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 10) {
                    Text("Card Details")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline.bold())
                    
                    if let cardForm = cardFormVM.cardForm {
                        SecureTextField(cardFormCollector: cardForm, type: .cardNumber, placeholder: {
                            Text("0000 0000 0000 0000").foregroundColor(.gray)
                        })
                        .cardFormStyle(isOnFocused: cardFormVM.cardState.isOnFocused,
                                       errorMessage: cardFormVM.cardState.errorMessage, imageURL: cardFormVM.cardImageURL)
                        .focused($focusedField, equals: .cardNumber) // Bind focus state
                        .onChange(of: cardFormVM.cardState.inputLength) { length in
                            if length == 16 && cardFormVM.cardState.isValid ?? false { focusedField = .cvv }
                        }
                        
                        SecureTextField(cardFormCollector: cardForm, type: .cvv, placeholder: {
                            Text("000").foregroundColor(.gray)
                        })
                        .cardFormStyle(isOnFocused: cardFormVM.cvvState.isOnFocused,
                                            errorMessage: cardFormVM.cvvState.errorMessage)
                        .focused($focusedField, equals: .cvv)
                        .onChange(of: cardFormVM.cvvState.inputLength) { length in
                            if length == 3 && cardFormVM.cvvState.isValid ?? false { focusedField = .expireMonth }
                        }
                        
                        HStack {
                            SecureTextField(cardFormCollector: cardForm, type: .expireMonth, placeholder: {
                                Text("MM").foregroundColor(.gray)
                            })
                            .cardFormStyle(isOnFocused: cardFormVM.expireMonthState.isOnFocused,
                                                errorMessage: cardFormVM.expireMonthState.errorMessage)
                            .focused($focusedField, equals: .expireMonth)
                            .onChange(of: cardFormVM.expireMonthState.inputLength) { length in
                                if length == 2 && cardFormVM.expireMonthState.isValid ?? false { focusedField = .expireYear }
                            }
                            
                            Text("-")
                            
                            SecureTextField(cardFormCollector: cardForm, type: .expireYear, placeholder: {
                                Text("YY").foregroundColor(.gray)
                            })
                            .cardFormStyle(isOnFocused: cardFormVM.expireYearState.isOnFocused,
                                                errorMessage: cardFormVM.expireYearState.errorMessage)
                            .focused($focusedField, equals: .expireYear)
                            .onChange(of: cardFormVM.expireYearState.inputLength) { length in
                                if length == 2 && cardFormVM.expireYearState.isValid ?? false { focusedField = .cardHolderName }
                            }
                        }
                        
                        SecureTextField(cardFormCollector: cardForm, type: .cardHolderName, placeholder: {
                            Text("Your Name").foregroundColor(.gray)
                        })
                        .cardFormStyle(isOnFocused: cardFormVM.holderNameState.isOnFocused,
                                            errorMessage: cardFormVM.holderNameState.errorMessage)
                        .focused($focusedField, equals: .cardHolderName)
                    }

                    // Submit Button
                    Button(action: {
                        cardFormVM.submit()
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 2)
                    }
                    .padding(.top, 20)
                }
                .background(Color.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.green, lineWidth: 1)
                        .shadow(color: Color.gray.opacity(1), radius: 2, x: 0, y: 2)
                        .background(content: {
                            Triangle().fill(Color.green)
                        })
                )
                .padding()
            }
        }
    }
}

struct Triangle: Shape {
    var size: CGFloat = 50
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from the top left corner of the frame
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        // Draw line to the top right corner
        path.addLine(to: CGPoint(x: rect.maxX - size, y: rect.minY))
        // Draw line to the bottom left corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + size))
        // Close the path to create the triangle
        path.closeSubpath()
        
        return path
    }
}
