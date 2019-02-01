//
//  InputVCtrl.swift
//  TwitSplit
//
//  Created by Lu Kien Quoc on 2/1/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import UIKit

class InputVCtrl: UIViewController {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txvInput: UITextView!
    
    var handleDone: (([String]) -> ())? = nil
    
    private let PLACEHOLDER_TEXT = "Your Message..."
    private let PLACEHOLDER_COLOR = UIColor.lightGray
    private let DEFAULT_COLOR = UIColor.black
    
    private var placeholderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configTextView()
        btnDone.isEnabled = false

    }

    private func configTextView() {
        txvInput.delegate = self
        txvInput.becomeFirstResponder()
        setupTextViewPlaceholder()
        addLabelCharacterCounter()
    }
    
    private func setupTextViewPlaceholder() {
        placeholderLabel = UILabel()
        placeholderLabel.font = txvInput.font
        placeholderLabel.textColor = PLACEHOLDER_COLOR
        placeholderLabel.text = PLACEHOLDER_TEXT
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (txvInput.font?.pointSize ?? 17) / 2)
        placeholderLabel.isHidden = false
        
        txvInput.addSubview(placeholderLabel)
    }
    
    private func addLabelCharacterCounter() {
        let accessoryView = UIView()
        accessoryView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44)
        accessoryView.backgroundColor = UIColor.groupTableViewBackground
        
        let counterLabel  = UILabel()
        counterLabel.text = "0"
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        accessoryView.addSubview(counterLabel)
        
        // setup contraint
        accessoryView.trailingAnchor.constraint(equalTo: counterLabel.trailingAnchor, constant: 20).isActive = true
        accessoryView.centerYAnchor.constraint(equalTo: counterLabel.centerYAnchor).isActive = true
        
        // add accessoryView to text view
        txvInput.inputAccessoryView = accessoryView
    }

    
    @IBAction func btnClose_Touched(_ sender: UIButton) {
        txvInput.becomeFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDone_Touched(_ sender: UIButton) {
        if let input = txvInput.text, !input.isEmpty {
            let splitMsg = Base.splitMessage(input)
            
            if splitMsg.isEmpty {
                showErrorAlert()
                
            } else {
                txvInput.resignFirstResponder()
                dismiss(animated: true) { [weak self] in
                    self?.handleDone?(splitMsg)
                }
                
            }
        }

    }
    
    private func showErrorAlert() {
        let alertCtrl = UIAlertController(title: "Warning", message: "Your message is invalid.", preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: {
            action in
            self.txvInput.selectedTextRange = self.txvInput.textRange(from: self.txvInput.beginningOfDocument , to: self.txvInput.endOfDocument)
        })
        alertCtrl.addAction(dismissAction)
        
        present(alertCtrl, animated: true, completion: nil)
    }

}

extension InputVCtrl: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // check if button share should be disable
        btnDone.isEnabled = !textView.text.isEmpty
        
        // check if placeholderLabel should be visible or not
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        // set value for label character counter
        if let lblCounter = textView.inputAccessoryView?.subviews.filter({$0 is UILabel}).first as? UILabel{
            lblCounter.text = "\(textView.text.count)"
        }
    }
}

