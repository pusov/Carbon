// swiftlint:disable line_length
// swiftlint:disable function_parameter_count

/// The custom parameter attribute that constructs sections from multi-statement closures.
@resultBuilder
public struct SectionsBuilder: SectionsBuildable {
    @usableFromInline
    internal var sections: [Section]

    /// Build an array of section.
    public func buildSections() -> [Section] {
        sections
    }
    
    @inlinable
    public static func buildExpression<C: SectionsBuildable>(_ s: C) -> SectionsBuilder {
        SectionsBuilder(s)
    }

    /// :nodoc:
    @inlinable
    public static func buildBlock() -> SectionsBuilder {
        SectionsBuilder()
    }

    /// :nodoc:
    @inlinable
    public static func buildBlock<S: SectionsBuildable>(_ s: S...) -> SectionsBuilder {
        SectionsBuilder(s)
    }

    /// :nodoc:
    @inlinable
    public static func buildOptional<S: SectionsBuildable>(_ s: S?) -> SectionsBuilder {
        s.map { SectionsBuilder($0) } ?? SectionsBuilder()
    }

    /// :nodoc:
    @inlinable
    public static func buildEither<S: SectionsBuildable>(first: S) -> SectionsBuilder {
        SectionsBuilder(first)
    }

    /// :nodoc:
    @inlinable
    public static func buildEither<S: SectionsBuildable>(second: S) -> SectionsBuilder {
        SectionsBuilder(second)
    }
    
    @inlinable
    public static func buildArray<S: SectionsBuildable>(_ components: [S]) -> SectionsBuilder {
        SectionsBuilder(components)
    }
    
    @inlinable
    public static func buildLimitedAvailability<S: SectionsBuildable>(_ component: S) -> SectionsBuilder {
        SectionsBuilder(component)
    }
}

internal extension SectionsBuilder {
    @usableFromInline
    init() {
        sections = []
    }

    @usableFromInline
    init<S: SectionsBuildable>(_ s: [S]) {
        sections = s.map { $0.buildSections() }.reduce([], + )
    }

    @usableFromInline
    init<S: SectionsBuildable>(_ s: S...) {
        self.init(s)
    }
}
