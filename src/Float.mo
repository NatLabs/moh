import Debug "mo:base/Debug";
import Float "mo:base/Float";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

import IntModule "Int";

module {
    public func log2(n : Float) : Float {
        Float.log(n) / Float.log(2);
    };

    public func logn(number : Float, base : Float) : Float {
        Float.log(number) / Float.log(base);
    };

    // todo: parse scientific notation (e.g. 1.23e-4)

    public func fromText(t : Text) : ?Float {
        let arr = Iter.toArray(Text.split(t, #text "."));

        let number = switch (IntModule.fromText(arr[0])) {
            case (?n) Float.fromInt(n);
            case (null) return null;
        };

        let decimals = switch (IntModule.fromText(arr[1])) {
            case (?d) Float.fromInt(d) / Float.fromInt(10 ** arr[1].size());
            case (null) return null;
        };

        let isNegative = number < 0;

        let float = if (isNegative) {
            number - decimals;
        } else {
            number + decimals;
        };

        ?float;
    };
};
