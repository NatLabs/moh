import Debug "mo:base/Debug";
import Float "mo:base/Float";
import Iter "mo:base/Iter";
import Char "mo:base/Char";
import Nat64 "mo:base/Nat64";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Buffer "mo:base/Buffer";

import ArrayModule "Array";
import Conversion "Conversion";

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

    public func toBigEndian(n : Nat) : [Nat8] {
        let n64 = Nat64.fromNat(n);

        var n_bytes : Nat64 = if (n < 0x80) {
            1;
        } else if (n < 0x8000) {
            2;
        } else if (n < 0x80000000) {
            3;
        } else {
            4;
        };

        let buf = Buffer.Buffer<Nat8>(Nat64.toNat(n_bytes));

        while (n_bytes > 0) {
            n_bytes -= 1;
            let b = (n64 >> (n_bytes * 8)) & 0xff;
            let byte = Nat8.fromNat(Nat64.toNat(b));
            buf.add(byte);
        };

        return Buffer.toArray(buf);
    };

    public func toLittleEndian(n : Nat) : [Nat8] {
        ArrayModule.reverse<Nat8>(toBigEndian(n));
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

};
