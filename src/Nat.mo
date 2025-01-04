import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Float "mo:base/Float";
import Iter "mo:base/Iter";
import Char "mo:base/Char";
import Nat64 "mo:base/Nat64";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Buffer "mo:base/Buffer";

import ArrayModule "Array";

module {
    public func isPrime(n : Nat) : Bool {
        let f = Float.fromInt(n);
        let sqrt = Float.sqrt(f);

        for (i in Iter.range(2, Float.toInt(sqrt))) {
            if (n % i == 0) {
                return false;
            };
        };

        return n > 1;
    };

    public func fromBytes(bytes : [Nat8]) : Nat {
        var n : Nat = 0;

        for (b in bytes.vals()) {
            n := (n * 256) + Nat8.toNat(b);
        };

        return n;
    };

    public func toBytes(num : Nat, nbytes: Nat): [Nat8]{
        ArrayModule.reverse<Nat8>(toBytes(num, nbytes));
    };

    public func toLeBytes(num : Nat, nbytes: Nat) : [Nat8] {
        var n = num;

        Array.tabulate(
            nbytes,
            func (_: Nat) : Nat8 {
                if ( n == 0) {
                    return 0;
                };

                let byte = Nat8.fromNat(n % 256);
                n /= 256;
                byte
            }
        )
    };

    public func fromText(text : Text) : Nat {
        var n : Nat = 0;

        for (c in text.chars()) {
            if (Char.isDigit(c)) {
                n := n * 10 + Nat32.toNat(Char.toNat32(c) - Char.toNat32('0'));
            } else {
                Debug.trap("Invalid character in number: " # Char.toText(c));
            };
        };

        return n;
    };

    public func parse(text : Text) : ?Nat {
        var n : Nat = 0;

        for (c in text.chars()) {
            if (Char.isDigit(c)) {
                n := n * 10 + Nat32.toNat(Char.toNat32(c) - Char.toNat32('0'));
            } else {
                return null;
            };
        };

        return ?n;
    };

    public func divCeil(num : Nat, divisor : Nat) : Nat {
        (num + (divisor - 1)) / divisor;
    };

};
