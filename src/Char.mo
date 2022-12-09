import Char "mo:base/Char";

module {
    public func toLowercase(c : Char) : Char {
        if (Char.isUppercase(c)) {
            let n = Char.toNat32(c);

            //difference between the nat32 values of 'a' and 'A'
            let diff : Nat32 = 32;
            return Char.fromNat32(n + diff);
        };

        return c;
    };

    public func toUppercase(c : Char) : Char {
        if (Char.isLowercase(c)) {
            let n = Char.toNat32(c);

            //difference between the nat32 values of 'a' and 'A'
            let diff : Nat32 = 32;
            return Char.fromNat32(n - diff);
        };

        return c;
    };

    public func isAlphanumeric(c : Char) : Bool {
        Char.isDigit(c) or Char.isAlphabetic(c);
    };
};
