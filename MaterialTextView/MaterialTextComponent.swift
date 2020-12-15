//
//  MaterialTextComponent.swift
//  MaterialTextView
//
//  Created by Mikhail Motyzhenkov on 07/05/2019.
//  Copyright © 2019 QIWI. All rights reserved.
//

import Foundation
import FormattableTextView
import UIKit

public protocol MaterialTextComponent: class, UITextInput {
	var keyboardType: UIKeyboardType { get set }
	var keyboardAppearance: UIKeyboardAppearance { get set }
	var returnKeyType: UIReturnKeyType { get set }
	var autocapitalizationType: UITextAutocapitalizationType { get set }
	var autocorrectionType: UITextAutocorrectionType { get set }
	var inputView: UIView? { get set }
	var inputAccessoryView: UIView? { get set }
	var currentFormat: String? { get }
	var allowSmartSuggestions: Bool { get set }
	
	@available(iOS 10.0, *)
	var textContentType: UITextContentType! { get set }
}

internal protocol MaterialTextComponentInternal: MaterialTextComponent, FormattableInput {
	var inputText: String { get set }
	var inputAttributedText: NSAttributedString { get set }
}

extension FormattableKernTextView: MaterialTextComponentInternal {
	
	public var inputAttributedText: NSAttributedString {
		get { return formats.isEmpty ? attributedText :
			NSAttributedString(string: text, attributes: inputAttributes)
		}
		set { attributedText = newValue }
	}
	
	public var inputText: String {
		get { return formats.isEmpty ? self.inputAttributedText.string : self.text }
		set {
			if formats.isEmpty {
				self.inputAttributedText = NSAttributedString(string: newValue, attributes: inputAttributes)
			} else {
				self.text = newValue
			}
		}
	}
}

extension FormattableTextField: MaterialTextComponentInternal {
	
	public var inputAttributedText: NSAttributedString {
		get {
			if !formats.isEmpty {
				return NSAttributedString(string: text, attributes: inputAttributes)
			}
			if let attrText = attributedText {
				return attrText
			}
			let attrText = NSAttributedString(string: inputText, attributes: inputAttributes)
			self.attributedText = attrText
			return attrText
		}
		set { attributedText = newValue }
	}
	
	public var inputText: String {
		get { return formats.isEmpty ? self.inputAttributedText.string : self.text }
		set {
			if formats.isEmpty {
				self.inputAttributedText = NSAttributedString(string: newValue, attributes: inputAttributes)
			} else {
				self.text = newValue
			}
		}
	}
}
