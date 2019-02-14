// TODO: Better naming...
// This is split up in two protocols because of the generic constraints.
public protocol Changeable: AnyObject {
    var hasChanged: ((Bool) -> ())? { get set }
    
    func determineHasBeenChanged() -> Bool
    func reset()
}

public protocol ChangeableValues: Changeable {
    associatedtype T: Equatable
    
    var currentValue: T { get set }
    
    /// Optional since we don't always have the old value available when initializing the table view row.
    var oldValue: T? { get }
}

public extension ChangeableValues {
    func determineHasBeenChanged() -> Bool {
        return currentValue != oldValue!
    }
    
    func reset() {
        // If you want to reset the current row, it should and must have an oldValue.
        currentValue = oldValue!
    }
}
