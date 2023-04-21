import Debug "mo:base/Debug";

module {
    /// Checks if a condition is true, and trap if it is not.
    public func assertTrue(cond : Bool, msg : Text) {
        if (not cond){
            Debug.trap(msg);
        };
    };

    /// Checks if a condition is false, and trap if it is not.
    public func assertFalse(cond : Bool, msg : Text) {
        if (cond){
            Debug.trap(msg);
        };
    };
};
