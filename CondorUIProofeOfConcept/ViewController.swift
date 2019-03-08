//
//  ViewController.swift
//  CondorUIProofeOfConcept
//
//  Created by Luis David Goyes Garces on 3/7/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
import CondorUIComponentsIOS

class ViewController: UIViewController {

    struct Regex {
        static let ssn = "^[0-9]{9}$"
        static let npi = "^[0-9]{10}$"
        static let phone = "^[0-9]{3}[-]{1}[0-9]{3}[-]{1}[0-9]{4}$"
        static let zip = "^[0-9]{5}$"
        static let email = "^[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])*$"
        static let any = "(.*?)"
    }

    @IBOutlet weak var stackView: UIStackView!

    var defaultTextFieldFrame: CGRect {
        return CGRect(x: 0, y: 0, width: stackView.bounds.width, height: 58)
    }

    var phoneTextField: UIView?
    var emailTextField: UIView?
    var currencyTextField: UIView?
    var startDateField: UIView?
    var endDateField: UIView?

    var fields: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFields()

        fields.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private func setupFields() {
        setupPhoneTextField()
        setupEmailTextField()
        setupCurrencyTextField()
        setupStartDateField()
        setupEndDateField()
    }

    private func setupPhoneTextField() {
        phoneTextField = TextRegexFormField(frame: defaultTextFieldFrame)

        guard let field = self.phoneTextField as? TextRegexFormFieldProtocol else {
            return
        }

        field.set(placeholder: "Phone")
        field.set(format: .phone)
        field.set(regex: Regex.phone)
        field.set(maxLength: 12)

        self.appendForm(field: self.phoneTextField)
    }

    private func setupEmailTextField() {
        emailTextField = TextRegexFormField(frame: defaultTextFieldFrame)

        guard let field = self.emailTextField as? TextRegexFormFieldProtocol else {
            return
        }

        field.set(placeholder: "Email")
        field.set(regex: Regex.email)

        self.appendForm(field: self.emailTextField)
    }

    private func setupCurrencyTextField() {
        currencyTextField = TextRegexFormField(frame: defaultTextFieldFrame)

        guard let field = self.currencyTextField as? TextRegexFormFieldProtocol else {
            return
        }

        field.set(placeholder: "Currency")
        field.set(format: .currency)

        self.appendForm(field: self.currencyTextField)
    }

    private func setupStartDateField() {
        startDateField = DateFormField(frame: defaultTextFieldFrame)
        
        guard let field = self.startDateField as? DateFormFieldType else {
            return
        }
        
        self.appendForm(field: self.startDateField)
    }
    
    private func setupEndDateField() {
        endDateField = DateFormField(frame: defaultTextFieldFrame)
        
        guard let field = self.endDateField as? DateFormFieldType else {
            return
        }
        
        self.appendForm(field: self.endDateField)
    }

    private func appendForm(field: UIView?) {
        if let field = field {
            fields.append(field)
        }
    }
}

