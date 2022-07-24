//
//  CustomView.swift
//  TodoListApp
//
//  Created by Elias Gabriel on 24/07/22.
//

import UIKit

protocol CustomViewCodeProtocol {
    func subviews()
    func layout()
}

extension CustomViewCodeProtocol {
    func commonInit(){
        subviews()
        layout()
    }
}
