//
//  Animation+StaticFactory.swift
//  SweetUI
//
//  Created by Maxim on 7/22/19.
//

import UICocoa

#if os(iOS)

public extension Animation {
    
    static func fadeOut(
        duration: TimeInterval = 0.6,
        delay: TimeInterval = 0,
        curve: UIView.AnimationCurve = .linear,
        completion: ((UIViewAnimatingPosition) -> Void)? = .none
    ) -> Animation {
        .init(
            duration: duration,
            delay: delay,
            curve: curve,
            operations: { $0.alpha = 0 },
            completion: completion
        )
    }
    
    static func fadeIn(
        duration: TimeInterval = 0.6,
        delay: TimeInterval = 0,
        curve: UIView.AnimationCurve = .linear,
        completion: ((UIViewAnimatingPosition) -> Void)? = .none
    ) -> Animation {
        .init(
            duration: duration,
            delay: delay,
            curve: curve,
            operations: { $0.alpha = 1 },
            completion: completion
        )
    }
    
    static func resize(
        to size: CGSize,
        duration: TimeInterval = 0.6,
        delay: TimeInterval = 0,
        curve: UIView.AnimationCurve = .linear,
        completion: ((UIViewAnimatingPosition) -> Void)? = .none
    ) -> Animation {
        .init(
            duration: duration,
            delay: delay,
            curve: curve,
            operations: { $0.bounds.size = size },
            completion: completion
        )
    }
    
    static func move(
        origin point: CGPoint,
        duration: TimeInterval = 0.6,
        delay: TimeInterval = 0,
        curve: UIView.AnimationCurve = .linear,
        completion: ((UIViewAnimatingPosition) -> Void)? = .none) -> Animation {
        .init(
            duration: duration,
            delay: delay,
            curve: curve,
            operations: { $0.frame.origin = point },
            completion: completion
        )
    }
    
    static func move(
        center point: CGPoint,
        duration: TimeInterval = 0.6,
        delay: TimeInterval = 0,
        curve: UIView.AnimationCurve = .linear,
        completion: ((UIViewAnimatingPosition) -> Void)? = .none) -> Animation {
        .init(
            duration: duration,
            delay: delay,
            curve: curve,
            operations: { $0.center = point },
            completion: completion
        )
    }
    
}

#endif
