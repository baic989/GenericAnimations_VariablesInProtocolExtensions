//
//  UIViewExtensions.swift
//  GenericAnimationsWithVariablesInProtocolExtension
//
//  Created by Hrvoje Baic on 05/12/2017.
//  Copyright © 2017 Hrvoje Baic. All rights reserved.
//

import UIKit

extension UIView: FlowAnimatable {
    
    // MARK: - Properties -
    
    private static let oldConstraintAssociation = ObjectAssociationHelper<NSLayoutConstraint>()
    private static let newConstraintAssociation = ObjectAssociationHelper<NSLayoutConstraint>()
    private static let fadeAssociation = ObjectAssociationHelper<NSNumber>()
    
    var oldConstraint: NSLayoutConstraint? {
        get { return UIView.oldConstraintAssociation[self] }
        set { UIView.oldConstraintAssociation[self] = newValue }
    }
    
    var newConstraint: NSLayoutConstraint? {
        get { return UIView.newConstraintAssociation[self] }
        set { UIView.newConstraintAssociation[self] = newValue }
    }
    
    var shouldFade: NSNumber? {
        get { return UIView.fadeAssociation[self] }
        set { UIView.fadeAssociation[self] = newValue }
    }
    
    // MARK: - Prepare for animation -
    
    func prepareForAnimationWith(type: AnimationType) {
        
        shouldFade = 0
        
        switch type {
        case .top:
            oldConstraint = _getConstraintMatching(attribute: .top)
            _prepareWith(constraint: oldConstraint, type: type)
        case .bottom:
            oldConstraint = _getConstraintMatching(attribute: .bottom)
            _prepareWith(constraint: oldConstraint, type: type)
        case .left:
            oldConstraint = _getConstraintMatching(attribute: .leading)
            _prepareWith(constraint: oldConstraint, type: type)
        case .right:
            oldConstraint = _getConstraintMatching(attribute: .trailing)
            _prepareWith(constraint: oldConstraint, type: type)
        case .fade:
            _prepareWith(constraint: nil, type: type)
        }
    }
    
    private func _prepareWith(constraint: NSLayoutConstraint?, type: AnimationType) {
        if let parent = superview {
            
            var constant: CGFloat
            
            switch type {
            case .top:
                constant = -self.intrinsicContentSize.height
                newConstraint = self.topAnchor.constraint(equalTo: parent.topAnchor, constant: constant)
            case .bottom:
                constant = self.intrinsicContentSize.height
                newConstraint = self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: constant)
            case .left:
                constant = -self.intrinsicContentSize.width
                newConstraint = self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: constant)
            case .right:
                constant = self.intrinsicContentSize.width
                newConstraint = self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: constant)
            case .fade:
                shouldFade = 1
                self.alpha = self.alpha > 0 ? 0 : 1
            }
            
            constraint?.isActive = false
            newConstraint?.isActive = true
        }
    }
    
    // MARK: - Animate -
    
    func animateIntro() {
        if let parent = superview {
            newConstraint?.isActive = false
            oldConstraint?.isActive = true
            
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                parent.layoutIfNeeded()
                self._view(shouldFade: self.shouldFade)
            }, completion: nil)
        }
    }
    
    func animateOutroWith(type: AnimationType) {
        if let parent = superview {
            prepareForAnimationWith(type: type)
            oldConstraint?.isActive = false
            newConstraint?.isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                parent.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func _view(shouldFade: NSNumber?) {
        if self.shouldFade == 1 {
            self.alpha = self.alpha > 0 ? 0 : 1
        }
    }
    
    // MARK: - Helpers -
    
    private func _getConstraintMatching(attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        if let parent = superview {
            for parentConstraint in parent.constraints {
                if let firstItem = parentConstraint.firstItem as? UIView, let secondItem = parentConstraint.secondItem as? UIView {
                    if firstItem == self && parentConstraint.firstAttribute == attribute || secondItem == self && parentConstraint.secondAttribute == attribute {
                        return parentConstraint
                    }
                }
            }
        }
        
        return nil
    }
}
