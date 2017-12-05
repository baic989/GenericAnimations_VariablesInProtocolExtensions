//
//  ViewController.swift
//  GenericAnimationsWithVariablesInProtocolExtension
//
//  Created by Hrvoje Baic on 05/12/2017.
//  Copyright © 2017 Hrvoje Baic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties -
    
    private let _topLabel: UILabel = {
        let label = UILabel()
        label.text = "Top"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let _bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Bottom"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let _leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Left"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let _rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Right"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let _fadeLabel: UILabel = {
        let label = UILabel()
        label.text = "Fade"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupViews()
        
        // After setting the layout, prepare for intro animations
        _topLabel.prepareForAnimationWith(type: .top)
        _bottomLabel.prepareForAnimationWith(type: .bottom)
        _leftLabel.prepareForAnimationWith(type: .left)
        _rightLabel.prepareForAnimationWith(type: .right)
        _fadeLabel.prepareForAnimationWith(type: .fade)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _topLabel.animateIntro()
        _bottomLabel.animateIntro()
        _leftLabel.animateIntro()
        _rightLabel.animateIntro()
        _fadeLabel.animateIntro()
    }
    
    // MARK: - Setup -
    
    private func _setupViews() {
        _setupTopLabel()
        _setupLeftLabel()
        _setupRightLabel()
        _setupBottomLabel()
        _setupFadeLabel()
    }
    
    private func _setupTopLabel() {
        view.addSubview(_topLabel)
        _topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    private func _setupBottomLabel() {
        view.addSubview(_bottomLabel)
        _bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _bottomLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    private func _setupLeftLabel() {
        view.addSubview(_leftLabel)
        _leftLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        _leftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
    }
    
    private func _setupRightLabel() {
        view.addSubview(_rightLabel)
        _rightLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        _rightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    private func _setupFadeLabel() {
        view.addSubview(_fadeLabel)
        _fadeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        _fadeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

