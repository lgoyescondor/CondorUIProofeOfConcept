//
//  ViewController.swift
//  CondorUIProofeOfConcept
//
//  Created by Luis David Goyes Garces on 3/7/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
import CondorUIComponentsIOS

class State: Selectable {
    var cities: [String]
    var name: String

    init(cities: [String], name: String) {
        self.cities = cities
        self.name = name
    }

    func getSelectableText() -> String {
        return name
    }
}

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
    var cityTextSelectionField: UIView?
    var stateSelectorField: UIView?

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
        setupCitySelectionField()
        setupStateSelectorField()
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
        field.set(placeholder: "Start date")
        field.set(notifiable: self)
        field.forbidDatesLaterThanToday()

        self.appendForm(field: self.startDateField)
    }

    private func setupEndDateField() {
        endDateField = DateFormField(frame: defaultTextFieldFrame)

        guard let field = self.endDateField as? DateFormFieldType else {
            return
        }
        field.set(placeholder: "End date")
        field.set(notifiable: self)
        field.forbidDatesLaterThanToday()

        self.appendForm(field: self.endDateField)
    }

    private func setupCitySelectionField() {
        cityTextSelectionField = TextSelectionFormField(frame: defaultTextFieldFrame)

        guard let field = self.cityTextSelectionField as? TextSelectionFormFieldProtocol else {
            return
        }
        field.set(placeholder: "City")

        self.appendForm(field: self.cityTextSelectionField)
    }

    private func setupStateSelectorField() {
        stateSelectorField = SelectorFormField(frame: defaultTextFieldFrame)

        guard let field = self.stateSelectorField as? SelectorFormFieldProtocol else {
            return
        }
        field.set(placeholder: "State")
        field.set(data: [State(cities: ["Medellin", "Envigado"], name: "Antioquia"), State(cities: ["Chia", "Bogota"], name: "Cundinamarca")])

        field.set(notifiable: self)

        self.appendForm(field: self.stateSelectorField)
    }

    private func appendForm(field: UIView?) {
        if let field = field {
            fields.append(field)
        }
    }
}

extension ViewController: DateFormFieldChangeNotifiable {
    func onSelected(dateString: String, date: Date, from datePicker: DateFormField) {
        switch datePicker {
        case startDateField:
            (endDateField as? DateFormFieldType)?.set(minimumDate: date)
        case endDateField:
            (startDateField as? DateFormFieldType)?.set(maximumDate: date)
        default:
            break
        }
    }
}

extension ViewController: SelectorFormFieldChangeNotifiable {
    func onSelected(row: Selectable, from selector: SelectorFormField) {
        switch selector {
        case stateSelectorField:
            if let selectedRow = selector.getSelectedRow() as? State {
                (cityTextSelectionField as? TextSelectionFormFieldProtocol)?.set(availableOptions: selectedRow.cities)
            }
        default:
            break
        }
    }
}

