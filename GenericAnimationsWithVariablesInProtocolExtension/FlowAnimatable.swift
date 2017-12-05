//
//  FlowAnimatable.swift
//  GenericAnimationsWithVariablesInProtocolExtension
//
//  Created by Hrvoje Baic on 05/12/2017.
//  Copyright © 2017 Hrvoje Baic. All rights reserved.
//

enum AnimationType {
    case top
    case bottom
    case left
    case right
    case fade
}

protocol FlowAnimatable: class {
    func prepareForAnimationWith(type: AnimationType)
    func animateIntro()
    func animateOutroWith(type: AnimationType)
}
