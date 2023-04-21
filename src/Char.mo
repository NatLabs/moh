import Char "mo:base/Char";
import Nat32 "mo:base/Nat32";

import Nat8Module "Nat8";
import Nat16Module "Nat16";
import Nat32Module "Nat32";
import Nat64Module "Nat64";

module {

    public func fromNat(n : Nat) : Char {
        Char.fromNat32(Nat32.fromNat(n));
    };

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

    public func toHexDigit(char : Char) : Nat8 {
        let charCode = Char.toNat32(char);

        if (Char.isDigit(char)) {
            let digit = charCode - Char.toNat32('0');

            return Nat32Module.toNat8(digit);
        };

        if (Char.isUppercase(char)) {
            let digit = charCode - Char.toNat32('A') + 10;

            return Nat32Module.toNat8(digit);
        };

        // lowercase
        let digit = charCode - Char.toNat32('a') + 10;

        return Nat32Module.toNat8(digit);
    };

    public func fromNat8(n: Nat8) : Char {
        let n32 = Nat8Module.toNat32(n);
        Char.fromNat32(n32);
    };

    public func fromNat16(n: Nat16) : Char {
        let n32 = Nat16Module.toNat32(n);
        Char.fromNat32(n32);
    };

    public func fromNat64(n: Nat64) : Char {
        let n32 = Nat64Module.toNat32(n);
        Char.fromNat32(n32);
    };

    public func toNat8(char : Char) : Nat8 {
        let charCode = Char.toNat32(char);
        Nat32Module.toNat8(charCode);
    };

    public func toNat16(char : Char) : Nat16 {
        let charCode = Char.toNat32(char);
        Nat32Module.toNat16(charCode);
    };

    public func toNat64(char : Char) : Nat64 {
        let charCode = Char.toNat32(char);
        Nat32Module.toNat64(charCode);
    };

};
