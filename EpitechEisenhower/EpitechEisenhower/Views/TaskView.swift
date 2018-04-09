//
//  TaskView.swift
//  EpitechEisenhower
//
//  Created by Kevin Djedje on 30/03/2018.
//

import UIKit

class TaskView: UIView {
    @IBOutlet private var important: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var urgent: UIImageView!
    
    
    private var ENABLE_BUTTON: CGFloat = 1.0
    private var DISABLE_BUTTON: CGFloat = 0.33
    
    public var task: Task?
    
    public enum Style {
        case importanteAndUrgente, importanteAndNotUrgente, NotImportanteAndUrgente, regular
    }
    
    public var style: Style = .regular {
        didSet {
            setStyle(style: style)
        }
    }
    
    public var title: String = "" {
        didSet {
            titleLabel!.text = title
        }
    }
    
    public var date: String = "" {
        didSet {
            dateLabel.text = date
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setUrgent(urgent: Bool) {
        if urgent {
            self.urgent!.alpha = ENABLE_BUTTON
        } else {
            self.urgent!.alpha = DISABLE_BUTTON
        }
    }
    
    public func setImportant(important: Bool) {
        if important {
            self.important!.alpha = ENABLE_BUTTON
        } else {
            self.important!.alpha = DISABLE_BUTTON
        }
    }
    
    private func setStyle(style: Style) {
        switch style {
        case .importanteAndUrgente:
            backgroundColor = #colorLiteral(red: 0.8962846398, green: 0.3378795683, blue: 0.1980339587, alpha: 1)
            setImportant(important: true)
            setUrgent(urgent: true)
        case .importanteAndNotUrgente:
            backgroundColor = #colorLiteral(red: 0.1337784827, green: 0.6588404179, blue: 0.7277467847, alpha: 1)
            setImportant(important: true)
            setUrgent(urgent: false)
        case .NotImportanteAndUrgente:
            backgroundColor = #colorLiteral(red: 0.4951201677, green: 0.8186448216, blue: 0.2723997831, alpha: 1)
            setImportant(important: false)
            setUrgent(urgent: true)
        case .regular:
            backgroundColor = #colorLiteral(red: 0.6855384111, green: 0.8403471112, blue: 0.5593820214, alpha: 1)
            setImportant(important: false)
            setUrgent(urgent: false)
        }
    }
}
