import Float "mo:base/Float";

module {
    public func log2(n : Float) : Float {
        Float.log(n) / Float.log(2);
    };
    
    public func logn(number : Float, base : Float) : Float {
        Float.log(number) / Float.log(base);
    };
};
