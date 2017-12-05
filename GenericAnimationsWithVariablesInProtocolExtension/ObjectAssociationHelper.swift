//
//  ObjectAssociationHelper.swift
//  GenericAnimationsWithVariablesInProtocolExtension
//
//  Created by Hrvoje Baic on 05/12/2017.
//  Copyright © 2017 Hrvoje Baic. All rights reserved.
//

import Foundation

final class ObjectAssociationHelper<T: AnyObject> {
    
    private let policy: objc_AssociationPolicy
    
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }
    
    public subscript(index: AnyObject) -> T? {
        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}
