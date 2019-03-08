//
//  Genesis.swift
//  CondorUIProofeOfConcept
//
//  Created by Luis David Goyes Garces on 3/7/19.
//  Copyright © 2019 Condor Labs. All rights reserved.
//

import UIKit
import CondorUIComponentsIOS

class Genesis: UIView {

    var textField: TextFormField?

    override init(frame: CGRect) {
        textField = TextFormField(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        textField?.backgroundColor = .yellow
        super.init(frame: frame)
        if let textField = self.textField {
            self.addSubview(textField)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
