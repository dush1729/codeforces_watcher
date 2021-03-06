//
//  AgreementTextView.swift
//  Codeforces Watcher
//
//  Created by Ivan Karavaiev on 2/9/21.
//  Copyright © 2021 xorum.io. All rights reserved.
//

import UIKit
import common

class AgreementTextView: UITextView, UITextViewDelegate {
    
    private var agreementText =  "agreement_terms_and_privacy".localized.attributed
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: nil)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        isEditable = false
        
        addTermsProperty()
        addPrivacyProperty()
        
        font = Font.textSubheadingBig
        textColor = Palette.black
        
        textAlignment = .left
        attributedText = agreementText
    }
    
    private func addTermsProperty() {
        let tag = "terms"
        let link = Constants().TERMS_AND_CONDITIONS_LINK
        
        let range = agreementText.getRangeAndRemoveTag(tag: tag)
        
        agreementText.run {
            $0.addLink(url: link, range: range)
            $0.addUnderline(range: range)
        }
    }
    
    private func addPrivacyProperty() {
        let tag = "privacy"
        let link = Constants().PRIVACY_POLICY_LINK
        
        let range = agreementText.getRangeAndRemoveTag(tag: tag)
        
        agreementText.run {
            $0.addLink(url: link, range: range)
            $0.addUnderline(range: range)
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
