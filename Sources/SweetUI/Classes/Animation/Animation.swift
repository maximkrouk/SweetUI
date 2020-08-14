//
//  Animation.swift
//  SweetUI
//
//  Created by Maxim on 7/22/19.
//

import UICocoa

#if os(iOS)

/// Wrapper for animation.
public struct Animation {
    
    /// Type of animation execution.
    public enum Mode {
        
        /// Animations will be executed one by one.
        case sequence
        
        /// Animations will be executed simultaneously.
        case parallel
    }
    
    /// The total duration of the animation operations, measured in seconds.
    ///
    /// If you specify a negative value or 0, the changes are made without animating them.
    public let duration: TimeInterval
    
    /// The amount of time (measured in seconds) to wait before beginning the animations.
    ///
    /// A value of 0 will begin the animations immediately.
    public let delay: TimeInterval
    
    public let curve: UIView.AnimationCurve
    
    /// A block object containing the changes to commit to the views.
    ///
    /// This is where you programmatically change any animatable properties of the views in your view hierarchy.
    /// This block takes no parameters and has no return value.
    public let operations: (UIView) -> Void
    
    /// A block object to be executed when the animation sequence ends.
    ///
    /// This block has no return value and takes a single Boolean argument that indicates
    /// whether or not the animations actually finished before the completion handler was called.
    /// If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle.
    public let completion: ((UIViewAnimatingPosition) -> Void)?
    
    /// Initializes and returns a newly allocated Animation object.
    ///
    /// - Parameter duration:
    /// The total duration of the animation operations, measured in seconds.
    /// If you specify a negative value or 0, the changes are made without animating them.
    ///
    /// - Parameter delay:
    /// The amount of time (measured in seconds) to wait before beginning the animations.
    /// Specify a value of 0 to begin the animations immediately.
    ///
    /// - Parameter curve:
    /// The UIKit timing curve to apply to the animation.
    ///
    /// - Parameter operations:
    /// A block object containing the changes to commit to the views.
    /// This is where you programmatically change any animatable properties of the views in your view hierarchy.
    /// This block takes no parameters and has no return value.
    ///
    /// - Parameter completion:
    /// A block to execute when the animations finish. This block has no return value and takes the following parameter:
    /// finalPosition
    /// The position where the animations stopped. Use this value to specify whether the animations stopped at their starting point, their end point, or their current position.
    init(
        duration: TimeInterval = 0.3,
        delay: TimeInterval = 0,
        curve: UIView.AnimationCurve = .linear,
        operations: @escaping (UIView) -> Void,
        completion: ((UIViewAnimatingPosition) -> Void)? = nil)
    {
        self.duration = duration
        self.delay = delay
        self.curve = curve
        self.operations = operations
        self.completion = completion
    }
    
}

#endif
