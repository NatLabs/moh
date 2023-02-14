import Debug "mo:base/Debug";

module {
    public func devPrint(msg : Text) {
        debug {
            Debug.print(msg)
        };
    };
};
