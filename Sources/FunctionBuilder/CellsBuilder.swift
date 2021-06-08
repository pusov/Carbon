// swiftlint:disable line_length
// swiftlint:disable function_parameter_count

/// The custom parameter attribute that constructs cells from multi-statement closures.
@resultBuilder
public struct CellsBuilder: CellsBuildable {
    @usableFromInline
    internal var cellNodes: [CellNode]

    /// Build an array of cell.
    @inlinable
    public func buildCells() -> [CellNode] {
        cellNodes
    }

    @inlinable
    public static func buildExpression<C: CellsBuildable>(_ c: C) -> CellsBuilder {
        CellsBuilder(c)
    }
    
    /// :nodoc:
    @inlinable
    public static func buildBlock() -> CellsBuilder {
        CellsBuilder()
    }

    /// :nodoc:
    @inlinable
    public static func buildBlock(_ c: CellsBuilder...) -> CellsBuilder {
        CellsBuilder(c)
    }

    /// :nodoc:
    @inlinable
    public static func buildOptional(_ c: CellsBuildable?) -> CellsBuilder {
        c.map { CellsBuilder($0) } ?? CellsBuilder()
    }

    /// :nodoc:
    @inlinable
    public static func buildEither(first: CellsBuildable) -> CellsBuilder {
        CellsBuilder(first)
    }

    /// :nodoc:
    @inlinable
    public static func buildEither(second: CellsBuildable) -> CellsBuilder {
        CellsBuilder(second)
    }
    
    @inlinable
    public static func buildArray<C: CellsBuildable>(_ components: [C]) -> CellsBuilder {
        CellsBuilder(components)
    }
    
    @inlinable
    public static func buildLimitedAvailability<C: CellsBuildable>(_ component: C) -> CellsBuilder {
        CellsBuilder(component)
    }
}

internal extension CellsBuilder {
    @usableFromInline
    init() {
        cellNodes = []
    }

    @usableFromInline
    init(_ c: CellsBuildable...) {
        self.init(c)
    }
    
    @usableFromInline
    init(_ c: [CellsBuildable]) {
        cellNodes = c.map { $0.buildCells() }.reduce([], +)
    }
}

