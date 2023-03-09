import Debug "mo:base/Debug";

module {
    public func assertion(cond : Bool, msg : Text) {
        if (not cond){
            Debug.print("Assertion failed: " # msg);
        };
    };
};
