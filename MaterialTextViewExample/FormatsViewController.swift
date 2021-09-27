//
//  FormatsViewController.swift
//  MaterialTextViewExample
//
//  Created by Mikhail Motyzhenkov on 07/08/2019.
//  Copyright © 2019 QIWI. All rights reserved.
//

import UIKit
import MaterialTextView

class FormatsViewController: UIViewController {

	@IBOutlet weak var tv: MaterialTextView!
	@IBOutlet weak var tf: MaterialTextView!
	@IBOutlet weak var stack: UIStackView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tv.viewModel = .init(text: "123456", help: "Max length is 5 symbols", textComponentMode: .textView, placeholder: .init(type: .animated, text: "Digits (TextView, animated)"), inputValidator: { $0.count > 5 ? .invalid(text: "Too long") : .valid }, formats: ["ddddddd"], rightButtonInfo: .init(imageName: "icon", action: nil))
		
		self.tf.viewModel = .init(textComponentMode: .textField, placeholder: .init(type: .normal, text: "Alphabet symbols only (TextField)"), inputValidator: { $0.count > 5 ? .invalid(text: "Too long") : .valid }, formats: ["wwwwwwwwwwwwwwwwww"], rightButtonInfo: .init(imageName: "icon", action: nil))
		
		// Create MaterialTextView programmatically
		let tv = MaterialTextView(MaterialTextViewModel(placeholder: .init(type: .animated, text: "Animated"), formats: ["ddddd $"], formatSymbols: ["d": CharacterSet.decimalDigits.union(CharacterSet(charactersIn: ",."))]))
		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.textComponent.keyboardType = .numberPad
		stack.addArrangedSubview(tv)
		
		let tv2 = MaterialTextView(MaterialTextViewModel(placeholder: .init(type: .animated, text: "Animated")))
		tv2.translatesAutoresizingMaskIntoConstraints = false
		stack.addArrangedSubview(tv2)
		
		let tv3 = MaterialTextView(MaterialTextViewModel(placeholder: .init(type: .alwaysOnTop, text: "Amount (always on top)"), formats: ["ddddddddddddddddddddddddd $"]))
		tv3.textComponent.keyboardType = .numberPad
		stack.addArrangedSubview(tv3)
		tv3.translatesAutoresizingMaskIntoConstraints = false
		
		let tv4 = MaterialTextView(MaterialTextViewModel(placeholder: .init(type: .alwaysOnTop, text: "Telephone number"), formats: ["+d (ddd) ddd-dd-dd"]))
		tv4.translatesAutoresizingMaskIntoConstraints = false
		if #available(iOS 10.0, *) {
			tv4.textComponent.textContentType = .telephoneNumber
			tv4.textComponent.keyboardType = .numberPad
			tv4.textComponent.allowSmartSuggestions = true
		}
		stack.addArrangedSubview(tv4)
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.tv.viewModel.text = ""
	}

}
