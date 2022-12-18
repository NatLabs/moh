import Text "mo:base/Text";

import NatModule "Nat";

module {
    public func fromText(t : Text) : ?Int {
        let chars = t.chars();

        let isNegative = switch (chars.next()) {
            case (?c) c == '-';
            case (null) { return null };
        };

        let text = Text.fromIter(chars);

        let n = switch (NatModule.fromText(text)) {
            case (?n) n;
            case (null) return null;
        };

        if (isNegative) {
            ?-n;
        } else {
            ?n;
        };
    };
};
