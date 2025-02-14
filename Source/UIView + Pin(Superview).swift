//
//  UIView + Pin(Superview).swift
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
    
    /// Pins the edge of the view using the specified type of relation to the
    /// given edge of its superview with the inset and priority of the constraint.
    ///
    /// 1. Consider, accordingly to
    /// [Apple's documentation](https://apple.co/2PFH9f2), you cannot pin edges
    /// with different axis, otherwise it will throw fatal error.
    ///
    /// 2. Use this method only if you want to pin the edge of the view to the
    /// opposite margin of its superview, in other cases
    /// [pinEdgeToSuperview(_:withInset:usingRelation:priority:)](x-source-tag://superview_toSameEdgeOfView_inset)
    /// would be a better approach.
    ///
    /// 3. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition:
    ///     - The view should have the superview, otherwise method will have no
    ///     effect.
    ///     - Pin edges with same axis or method will throw fatal error.
    ///
    /// - Parameter edge: The edge of this view to pin.
    /// - Parameter superviewEdge: The edge of its superview to pin to.
    /// - Parameter inset: The inset between the edge of this view and the edge of
    /// its superview.
    /// - Parameter relation: The type of relationship for constraint.
    /// - Parameter priority: The priority of the constraint.
    ///
    func pinEdge(
        _ edge: ESLEdge,
        toSuperviewEdge superviewEdge: ESLEdge,
        withInset inset: CGFloat = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        guard let superview = superview else { return }
        pinEdge(edge,
            toEdge: superviewEdge,
            ofView: superview,
            withInset: inset,
            usingRelation: relation,
            priority: priority
        )
    }
    
    /// Pins the given edge of the view using the specified type of relation to
    /// the corresponding margin of its superview with the inset and priority of
    /// the constraint.
    ///
    /// To make Auto-Layout works properly, it automatically sets view's property
    /// `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: The view should have the superview, otherwise this method
    /// will have no effect.
    ///
    /// - Parameter edge: The edge of this view to pin.
    /// - Parameter inset: The inset beetween the edge of this view and the
    /// corresponding edge of its superview.
    /// - Parameter relation: The type of relationship for constraint.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: superview_toSameEdgeOfView_inset
    ///
    func pinEdgeToSuperview(
        _ edge: ESLEdge,
        withInset inset: CGFloat = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        guard let superview = superview else { return }
        pinEdge(edge,
            toSameEdgeOfView: superview,
            withInset: inset,
            usingRelation: relation,
            priority: priority
        )
    }
    
    /// Pins the given edges of the view using the specified type of relation to
    /// the corresponding margins of its superview with the insets and priority of
    /// the constraints.
    ///
    /// 1. If you don't need to customize the insets based on the edge, use
    /// [pinEdgesToSuperview(_:withInset:usingRelation:priority:)](x-source-tag://superview_toSameEdgesOfView_inset).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's property
    /// `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: The view should have the superview, otherwise this method
    /// will have no effect.
    ///
    /// - Parameter edges: The edges of this view to pin.
    /// - Parameter insets: The insets beetween the edges of this view and the
    /// corresponding edges of its superview.
    /// - Parameter relation: The type of relationship for constraint.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: superview_toSameEdgesOfView_insets
    ///
    func pinEdgesToSuperview(
        _ edges: [ESLEdge] = ESLEdge.all,
        withInsets insets: UIEdgeInsets = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        guard let superview = superview else { return }
        pinEdges(edges,
           toSameEdgesOfView: superview,
           withInsets: insets,
           usingRelation: relation,
           priority: priority
        )
    }
    
    /// Pins the given edges of the view using the specified type of relation to
    /// the corresponding margins of its superview with the equal insets and
    /// priority of the constraints.
    ///
    /// 1. If you need to customize the insets based on the edge, use
    /// [pinEdgesToSuperview(_:withInsets:usingRelation:priority:)](x-source-tag://superview_toSameEdgesOfView_insets).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: The view should have the superview, otherwise this method
    /// will have no effect.
    ///
    /// - Parameter edges: The edges of this view to pin.
    /// - Parameter inset: The inset beetween the edges of this view and the
    /// corresponding edges of its superview.
    /// - Parameter relation: The type of relationship for constraint.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: superview_toSameEdgesOfView_inset
    ///
    func pinEdgesToSuperview(
        _ edges: [ESLEdge] = ESLEdge.all,
        withInset inset: CGFloat,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        pinEdgesToSuperview(edges,
            withInsets: UIEdgeInsets(inset: inset),
            usingRelation: relation,
            priority: priority
        )
    }
    
    /// Pins edges of the view of the given group using the specified type of
    /// relation to the corresponding margins of its superview with the equal
    /// insets and priority of the constraints.
    ///
    /// To make Auto-Layout works properly, it automatically sets view's property
    /// `translatesAutoresizingMaskIntoConstraints` to `false`.
    ///
    /// - Precondition: The view should have the superview, otherwise this method
    /// will have no effect.
    ///
    /// - Parameter group: The group of edges of this view to pin to.

    /// - Parameter inset: The inset beetween the edges of this view and
    /// corresponding edges of its superview.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    func pinEdgesToSuperview(
        ofGroup group: ESLEdgeGroup,
        withInset inset: CGFloat = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        guard let superview = superview else { return }
        pinEdges(
            ofGroup: group,
            toSameEdgesOfView: superview,
            withInset: inset,
            usingRelation: relation,
            priority: priority
        )
    }
    
    /// Pins the edges of the view using the specified type of relation to the
    /// corresponding margins of its superview with the insets and priority of the
    /// constraints, excluding one edge.
    ///
    /// 1. If you need to customize the insets based on the edge, use
    /// [pinEdgesToSuperview(excludingEdge:withInset:usingRelation:priority:)](x-source-tag://superview_excludingEdge_inset).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`
    ///
    /// - Precondition: The view should have the superview, otherwise this method
    /// will have no effect.
    ///
    /// - Parameter excludedEdge: The edge to be ingored and not pinned.
    /// - Parameter insets: The insets beetween the edges of this view and
    /// corresponding edges of another view.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: superview_excludingEdge_insets
    ///
    func pinEdgesToSuperview(
        excludingEdge excludedEdge: ESLEdge,
        withInsets insets: UIEdgeInsets = .zero,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        guard let superview = superview else { return }
        pinEdges(
            toSameEdgesOfView: superview,
            excludingEdge: excludedEdge,
            withInsets: insets,
            usingRelation: relation,
            priority: priority
        )
    }
    
    /// Pins the edges of the view using the specified type of relation to the
    /// corresponding margins of its superview with the equal inset and priority
    /// of the constraints, excluding one edge.
    ///
    /// 1. If you need to customize the insets based on the edge, use
    /// [pinEdgesToSuperview(excludingEdge:withInsets:usingRelation:priority:)](x-source-tag://superview_excludingEdge_insets).
    ///
    /// 2. To make Auto-Layout works properly, it automatically sets view's
    /// property `translatesAutoresizingMaskIntoConstraints` to `false`
    ///
    /// - Precondition: The view should have the superview, otherwise this method
    /// will have no effect.
    ///
    /// - Parameter excludedEdge: The edge to be ingored and not pinned.
    /// - Parameter inset: The inset beetween the edges of this view and
    /// corresponding edges of its superview.
    /// - Parameter relation: The type of relationship for the constraints.
    /// - Parameter priority: The priority of the constraint.
    ///
    /// - Tag: superview_excludingEdge_inset
    ///
    func pinEdgesToSuperview(
        excludingEdge excludedEdge: ESLEdge,
        withInset inset: CGFloat,
        usingRelation relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = .required
    ) {
        pinEdgesToSuperview(
            excludingEdge: excludedEdge,
            withInsets: UIEdgeInsets(inset: inset),
            usingRelation: relation,
            priority: priority
        )
    }
}
