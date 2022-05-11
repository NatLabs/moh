import Float "mo:base/Float";
import Iter "mo:base/Iter";

module{
    public func isPrime(n: Nat): Bool{
        let f = Float.fromInt(n);
        let sqrt = Float.sqrt(f);

        for (i in Iter.range(2, Float.toInt(sqrt))){
            if (n % i == 0){
                return false;
            }
        };

        return n > 1;
    };
}