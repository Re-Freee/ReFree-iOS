//
//  UIView+Gradation.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/10.
//

import UIKit

extension UIView {
    enum BackgroundType {
        case mainConic
        case mainAxial
        case reverseMainAxial
        case blackAxial
    }
    
    func gradientBackground(type: BackgroundType) {
        switch type {
        case .mainConic: mainConicBackground()
        case .mainAxial: mainAxialBackground()
        case .reverseMainAxial: reverseMainAxialBackground()
        case .blackAxial: blackAxialBackground()
        }
    }
    
    private func mainConicBackground() {
        let colors: [CGColor] = [
            UIColor.refreeColor.background1.cgColor,
            UIColor.refreeColor.background2.cgColor,
            UIColor.refreeColor.background3.cgColor,
            UIColor.refreeColor.background1.cgColor
        ]
        
        setGradientLayer(
            type: .conic,
            colors: colors,
            startPoint: CGPoint(x: 0.5, y: 0.5),
            endPoint: CGPoint(x: 0.5, y: 1),
            locations: [0.17, 0.5, 0.83]
        )
    }
    
    private func mainAxialBackground() {
        let colors: [CGColor] = [
            UIColor.white.cgColor,
            UIColor.refreeColor.background3.cgColor
        ]
        
        setGradientLayer(
            type: .axial,
            colors: colors,
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1),
            locations: nil
        )
    }
    
    private func reverseMainAxialBackground() {
        let colors: [CGColor] = [
            UIColor.refreeColor.background3.cgColor,
            UIColor.white.cgColor
            
        ]
        
        setGradientLayer(
            type: .axial,
            colors: colors,
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1),
            locations: nil
        )
    }
    
    private func blackAxialBackground() {
        let colors: [CGColor] = [
            UIColor.refreeColor.recipeBack1.cgColor,
            UIColor.refreeColor.recipeBack2.cgColor
        ]
        
        setGradientLayer(
            type: .axial,
            colors: colors,
            startPoint: CGPoint(x: 0.0, y: 0.0),
            endPoint: CGPoint(x: 1, y: 1),
            locations: [0.7]
        )
    }
    
    private func setGradientLayer(
        type: CAGradientLayerType,
        colors: [CGColor],
        startPoint: CGPoint,
        endPoint: CGPoint,
        locations: [NSNumber]?
    ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = locations
        gradientLayer.type = type
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
}
