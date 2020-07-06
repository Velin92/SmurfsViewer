import Foundation

typealias VoidHandler = (() -> Void)
typealias Handler<T> = ((_ value: T) -> Void)
typealias OptionalErrorHandler = Handler<Error?>

func delayedCall(_ delayInSeconds: Double = 0.0, closure: @escaping () -> Void) {
    let delayInMilliSeconds = Int(delayInSeconds * 1_000)
    let nanoseconds = DispatchTime.now() + DispatchTimeInterval.milliseconds(delayInMilliSeconds)
    DispatchQueue.main.asyncAfter(deadline: nanoseconds, execute: closure)
}
