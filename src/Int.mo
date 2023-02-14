import Text "mo:base/Text";

import NatModule "Nat";
import TextModule "Text";

module {
    public func fromText(t : Text) : Int {
        let isNegative = TextModule.subText(t, 0, 1) == "-";

        if (isNegative) {
            let suffix = TextModule.subText(t, 1, t.size());
            -NatModule.fromText(suffix);
        } else {
            NatModule.fromText(t);
        };
    };

    public func parse(t : Text) : ?Int {
        let isNegative = TextModule.subText(t, 0, 1) == "-";

        let optNum = if (isNegative) {
            let suffix = TextModule.subText(t, 1, t.size());
            NatModule.parse(suffix);
        } else {
            NatModule.parse(t);
        };

        switch (optNum) {
            case (?n) {
                if (isNegative) {
                    ?-n;
                } else {
                    ?n;
                };
            };
            case (null) return null;
        };
    };
};
