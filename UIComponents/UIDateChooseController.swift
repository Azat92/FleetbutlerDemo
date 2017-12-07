//
//  UIAlertController+DatesInterval.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

private protocol DateChooseAccessoryViewDelegate: NSObjectProtocol {
    
    func dateChooseDidClickToday(_ sender: DateChooseAccessoryView)
    func dateChoose(_ sender: DateChooseAccessoryView, didSetActiveField field: UITextField)
}

private class DateChooseAccessoryView: UIView {
    
    weak var delegate: DateChooseAccessoryViewDelegate?
    
    var textFields: [UITextField] = [] {
        didSet {
            textFields.forEach { $0.delegate = self }
        }
    }
    
    private (set) var activeField: UITextField? {
        didSet {
            if let field = activeField {
                if let index = textFields.index(of: field) {
                    backButton.isEnabled = index > 0
                    nextButton.isEnabled = index < textFields.count - 1
                }
                delegate?.dateChoose(self, didSetActiveField: field)
            }
        }
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage("btn_accessory_back".bundleImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.addTarget(self, action: #selector(backButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage("btn_accessory_next".bundleImage, for: .normal)
        button.frame = CGRect(x: 44, y: 0, width: 44, height: 44)
        button.addTarget(self, action: #selector(nextButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var todayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AlertStrings.DateChoose.today, for: .normal)
        button.frame = CGRect(x: 88, y: 0, width: self.width - 176, height: 44)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.autoresizingMask = .flexibleWidth
        button.addTarget(self, action: #selector(todayButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AlertStrings.clear, for: .normal)
        button.frame = CGRect(x: self.width - 88, y: 0, width: 88, height: 44)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.autoresizingMask = .flexibleLeftMargin
        button.addTarget(self, action: #selector(clearButtonDidClick(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleWidth
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(todayButton)
        addSubview(clearButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backButtonDidClick(_ sender: UIButton) {
        guard let field = activeField, let index = textFields.index(of: field), textFields.indices.contains(index - 1) else { return }
        textFields[index - 1].becomeFirstResponder()
    }
    
    @IBAction func nextButtonDidClick(_ sender: UIButton) {
        guard let field = activeField, let index = textFields.index(of: field), textFields.indices.contains(index + 1) else { return }
        textFields[index + 1].becomeFirstResponder()
    }
    
    @IBAction func todayButtonDidClick(_ sender: UIButton) {
        delegate?.dateChooseDidClickToday(self)
    }
    
    @IBAction func clearButtonDidClick(_ sender: UIButton) {
        activeField?.text = nil
    }
}

extension DateChooseAccessoryView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeField == textField {
            activeField = nil
        }
    }
}

/// Controller to display start and end date input fields
public final class UIDateChooseController: UIAlertController {
    
    /// Structure to return a result
    public struct Result {
        
        private static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter
        }()
        
        /// Selected start date
        public let startDate: Date?
        
        /// Selected end date
        public let endDate: Date?
        
        /// Formatted string appropriate to display in UI
        public var formatted: String {
            let fromString = AlertStrings.DateChoose.from
            let toString = AlertStrings.DateChoose.to
            if let start = startDate, let end = endDate {
                return "\(fromString) \(Result.formatter.string(from: start)) \(toString.lowercased()) \(Result.formatter.string(from: end))"
            }
            else if let start = startDate {
                return "\(fromString) \(Result.formatter.string(from: start))"
            }
            else if let end = endDate {
                return "\(toString) \(Result.formatter.string(from: end))"
            }
            else {
                return AlertStrings.DateChoose.recents
            }
        }
        
        fileprivate init(_ startDate: Date?, _ endDate: Date?) {
            self.startDate = startDate
            self.endDate = endDate
        }
        
        public static let empty = Result(nil, nil)
    }
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.backgroundColor = .white
        return picker
    }()
    
    private lazy var accessory: DateChooseAccessoryView = {
        let view = DateChooseAccessoryView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 44))
        view.delegate = self
        return view
    }()
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    public convenience init(startDate: Date?, endDate: Date?, completion: @escaping (Result) -> Void) {
        self.init(title: AlertStrings.DateChoose.title, message: AlertStrings.DateChoose.titleMessage, preferredStyle: .alert)
        let textFields = [
            addDateTextFieldWith(placeholder: AlertStrings.DateChoose.startDate),
            addDateTextFieldWith(placeholder: AlertStrings.DateChoose.endDate)
        ]
        accessory.textFields = textFields.flatMap { $0 }
        addAction(UIAlertAction(title: AlertStrings.ok, style: .default) { [weak self] _ in
            let dates = textFields.map { self?.formatter.date(from: $0?.text ?? "") }
            guard dates.count == 2, let startDate = dates.first, let endDate = dates.last else { return }
            completion(Result(startDate, endDate))
        })
        addAction(UIAlertAction(title: AlertStrings.cancel, style: .cancel, handler: nil))
        datePicker.addTarget(self, action: #selector(datePickerDidChange(_:)), for: .valueChanged)
    }
    
    private func addDateTextFieldWith(placeholder: String) -> UITextField? {
        var tf: UITextField?
        addTextField { [weak self] textField in
            textField.placeholder = placeholder
            textField.textAlignment = .center
            textField.inputView = self?.datePicker
            textField.inputAccessoryView = self?.accessory
            tf = textField
        }
        return tf
    }
    
    @IBAction func datePickerDidChange(_ sender: UIDatePicker) {
        accessory.activeField?.text = formatter.string(from: sender.date)
    }
}

extension UIDateChooseController: DateChooseAccessoryViewDelegate {
    
    fileprivate func dateChooseDidClickToday(_ sender: DateChooseAccessoryView) {
        let date = Date()
        datePicker.setDate(date, animated: true)
        accessory.activeField?.text = formatter.string(from: date)
    }
    
    fileprivate func dateChoose(_ sender: DateChooseAccessoryView, didSetActiveField field: UITextField) {
        if let text = field.text, let date = formatter.date(from: text) {
            datePicker.setDate(date, animated: true)
        }
    }
}
