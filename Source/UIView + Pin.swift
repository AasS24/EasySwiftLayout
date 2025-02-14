//
//  UIView + Pin.swift
//  https://github.com/denandreychuk/EasySwiftLayout
//
//  This code is distributed under the terms and conditions of the MIT license.
//  Copyright (c) 2019 Denis Andreychuk
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

public extension UIView {
    
    //MARK: - Abstraction for default
    
    /// Pins the edges to the given `NSLayoutAxisAnchor`s with the insets and
    /// priority of the constraints.
    ///
    /// 1. Compact version of default Swift layout. Allows you to pin edges to
    /// specific `NSLayoutAxisAnchor`.
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`
    ///
    /// - Precondition: You should pass at least one anchor, otherwise this method
    /// will have no effect.
    ///
    /// - Parameter top: The anchor to pin top to.
    /// - Parameter left: The anchor to pin left to.
    /// - Parameter bottom: The anchor to pin bottom to.
    /// - Parameter right: The anchor to pin right to.
    /// - Parameter insets: The insets between the edges.
    /// - Parameter priority: The priority of the constraints.
    ///
    func pin(
        topTo top: NSLayoutYAxisAnchor? = nil,
        leftTo left: NSLayoutXAxisAnchor? = nil,
        bottomTo bottom: NSLayoutYAxisAnchor? = nil,
        rightTo right : NSLayoutXAxisAnchor? = nil,
        withInsets insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) {
        guard top != nil || left != nil || bottom != nil || right != nil else { return }
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            let constraint = topAnchor.constraint(equalTo: top, constant: insets.top)
            constraint.priority = priority
            constraint.isActive = true
        }

        if let left = left {
            let constraint = leftAnchor.constraint(equalTo: left, constant: insets.left)
            constraint.priority = priority
            constraint.isActive = true
        }

        if let bottom = bottom {
            let constraint = bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom)
            constraint.priority = priority
            constraint.isActive = true
        }

        if let right = right {
            let constaint = rightAnchor.constraint(equalTo: right, constant: -insets.right)
            constaint.priority = priority
            constaint.isActive = true
        }
    }
    
    //MARK: - Pin Methods

    /// Pins the edge of the view using the specified type of relation to the
    /// given edge of another view with the inset and priority of the constraint.
    ///
    /// 1. Consider, accordingly to
    /// [Apple's documentation](https://apple.co/2PFH9f2), you cannot pin edges
    /// with different axis, otherwise it will throw fatal error.
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`
    ///
    /// - Precondition:
    ///     - Another view must be in the same view hierarchy as this view.
    ///     - Pin edges with same axis or method will throw fatal error.
    ///
    /// - Parameter edge: The edge of this view to pin.
    /// - Parameter pinningEdge: The edge of another view to pin to.
    /// - Parameter anotherView: Another view to pin to.
    /// - Parameter inset: The inset between the edge of this view and the edge of
    /// another view.
    /// - Parameter relation: The type of relationship for the constraint.
    /// - Parameter priority: The priority of the constraint.
    ///
    func pinEdge(
        _ edge: ESLEdge,
        toEdge pinningEdge: ESLEdge,
        ofView anotherView: UIView,
        withInset inset: CGFloat = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: edge.convertedToNSLayoutAttribute,
            relatedBy: relation,
            toItem: anotherView, attribute: pinningEdge.convertedToNSLayoutAttribute,
            multiplier: 1.0, constant: inset * edge.directionalMultiplier
        )
        constraint.priority = priority
        constraint.isActive = true
    }
    
    /// Pins the given edge of the view using the specified type of relation to
    /// the corresponding margin of another view with the inset and priority of
    /// the constraint.
    ///
    /// To make Auto-Layout works properly, it automatically sets view's property
    /// `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: Another view must be in the same view hierarchy as this
    /// view.
    ///
    /// - Parameter edge: The edge of this view to pin to.
    /// - Parameter anotherView: Another view to pin to.
    /// - Parameter inset: The inset beetween the edge of this view and the
    /// corresponding edge of another view.
    /// - Parameter relation: The type of relationship for the constraint.
    /// - Parameter priority: The priority of the constraint.
    ///
    func pinEdge(
        _ edge: ESLEdge,
        toSameEdgeOfView anotherView: UIView,
        withInset inset: CGFloat = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        pinEdge(edge,
            toEdge: edge, ofView: anotherView,
            withInset: inset,
            usingRelation: relation,
            priority: priority
        )
    }
    
    /// Pins the given edges of the view using the specified type of relation to
    /// the corresponding margins of another view with the insets and priority of
    /// the constraints.
    ///
    /// 1. If you don't need to customize the insets based on the edge, use
    /// [pinEdges(_:toSameEdgesOfView:withInset:usingRelation:priority:)](x-source-tag://toSameEdgesOfView_inset).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: Another view must be in the same view hierarchy as this
    /// view.
    ///
    /// - Parameter edges: The edges of this view to pin to.
    /// - Parameter anotherView: Another view to pin to.
    /// - Parameter insets: The insets beetween the edges of this view and
    /// corresponding edges of another view.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: toSameEdgesOfView_insets
    ///
    func pinEdges(
        _ edges: [ESLEdge] = ESLEdge.all,
        toSameEdgesOfView anotherView: UIView,
        withInsets insets: UIEdgeInsets = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        for edge in edges {
            switch edge {
            case .left:
                pinEdge(.left,
                    toSameEdgeOfView: anotherView,
                    withInset: insets.left,
                    usingRelation: relation,
                    priority: priority
                )
            case .right:
                pinEdge(.right,
                    toSameEdgeOfView: anotherView,
                    withInset: insets.right,
                    usingRelation: relation,
                    priority: priority
                )
            case .top:
                pinEdge(.top,
                    toSameEdgeOfView: anotherView,
                    withInset: insets.top,
                    usingRelation: relation,
                    priority: priority
                )
            case .bottom:
                pinEdge(.bottom,
                    toSameEdgeOfView: anotherView,
                    withInset: insets.bottom,
                    usingRelation: relation,
                    priority: priority
                )
            }
        }
    }
    
    /// Pins the given edges of the view using the specified type of relation to
    /// the corresponding margins of another view with the equal insets and
    /// priority of the constraints.
    ///
    /// 1. If you need to customize the insets based on the edge, use
    /// [pinEdges(_:toSameEdgesOfView:withInsets:usingRelation:priority:)](x-source-tag://toSameEdgesOfView_insets).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property`translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: Another view must be in the same view hierarchy as this
    /// view.
    ///
    /// - Parameter edges: The edges of this view to pin to.
    /// - Parameter anotherView: Another view to pin to.
    /// - Parameter inset: The inset beetween the edges of this view and
    /// corresponding edges of another view.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: toSameEdgesOfView_inset
    ///
    func pinEdges(
        _ edges: [ESLEdge] = ESLEdge.all,
        toSameEdgesOfView anotherView: UIView,
        withInset inset: CGFloat,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        pinEdges(edges,
             toSameEdgesOfView: anotherView,
             withInsets: UIEdgeInsets(inset: inset),
             usingRelation: relation,
             priority: priority
        )
    }
    
    /// Pins edges of the view of the given group using the specified type of
    /// relation to the corresponding margins of another view with the equal
    /// insets and priority of the constraints.
    ///
    /// To make Auto-Layout works properly, it automatically sets view's property
    /// `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: Another view must be in the same view hierarchy as this
    /// view.
    ///
    /// - Parameter edgeGroup: The group of edges of this view to pin to.
    /// - Parameter anotherView: Another view to pin to.
    /// - Parameter inset: The inset beetween the edges of this view and
    /// corresponding edges of another view.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    func pinEdges(
        ofGroup edgeGroup: ESLEdgeGroup,
        toSameEdgesOfView anotherView: UIView,
        withInset inset: CGFloat,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        pinEdges(edgeGroup.edges,
             toSameEdgesOfView: anotherView,
             withInset: inset,
             usingRelation: relation,
             priority: priority
        )
    }
    
    
    /// Pins the edges of the view using the specified type of relation to the
    /// corresponding margins of another view with the insets and priority of the
    /// constraints, excluding one edge.
    ///
    /// 1. If you don't need to customize the insets based on the edge, use
    /// [pinEdges(toSameEdgesOfView:excludingEdge:withInset:usingRelation:priority:)](x-source-tag://excludingEdge_inset).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: Another view must be in the same view hierarchy as this
    /// view.
    ///
    /// - Parameter anotherView: Another view to pin to.
    /// - Parameter excludedEdge: The edge to be ingored and not pinned.
    /// - Parameter insets: The insets beetween the edges of this view and
    /// corresponding edges of another view.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: excludingEdge_insets
    ///
    func pinEdges(
        toSameEdgesOfView anotherView: UIView,
        excludingEdge excludedEdge: ESLEdge,
        withInsets insets: UIEdgeInsets = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        let edges = ESLEdge.all.filter { $0 != excludedEdge }
        pinEdges(edges,
             toSameEdgesOfView: anotherView,
             withInsets: insets,
             usingRelation: relation,
             priority: priority
        )
    }
    
    /// Pins the edges of the view using the specified type of relation to the
    /// corresponding margins of another view with the equal inset and priority of
    /// the constraints, excluding one edge.
    ///
    /// 1. If you need to customize the inset based on the edge, use
    /// [pinEdges(toSameEdgesOfView:excludingEdge:withInsets:usingRelation:priority:)](x-source-tag://excludingEdge_insets).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: Another view must be in the same view hierarchy as this
    /// view.
    ///
    /// - Parameter anotherView: Another view to pin to.
    /// - Parameter excludedEdge: The edge to be ingored and not pinned.
    /// - Parameter inset: The inset beetween the edges of this view and
    /// corresponding edges of another view.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: excludingEdge_inset
    ///
    func pinEdges(
        toSameEdgesOfView anotherView: UIView,
        excludingEdge excludedEdge: ESLEdge,
        withInset inset: CGFloat,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        pinEdges(
            toSameEdgesOfView: anotherView,
            excludingEdge: excludedEdge,
            withInsets: UIEdgeInsets(inset: inset),
            usingRelation: relation, priority: priority
        )
    }
}
