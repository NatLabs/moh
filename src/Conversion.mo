import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Nat64 "mo:base/Nat64";

import Nat "mo:base/Nat";
import Int "mo:base/Int";

/// Primitive type conversion functions.
module{
    public func nat8ToChar(n8: Nat8): Char{
        let n = Nat8.toNat(n8);
        let n32 = Nat32.fromNat(n);
        Char.fromNat32(n32);
    };

    public func charToNat8(char: Char): Nat8{
        let n32 = Char.toNat32(char);
        let n = Nat32.toNat(n32);
        let n8 = Nat8.fromNat(n);
    };

    /// #Nat
    /// Nat to Int
    public func natToInt(n: Nat): Int{
        let int: Int = n;
        int
    };

    public func nat8ToNat64(n8: Nat8): Nat64{
        let n = Nat8.toNat(n8);
        let n64 = Nat64.fromNat(n);
        n64
    };

    public func nat64ToNat8(n64: Nat64): Nat8{
        let n = Nat64.toNat(n64);
        let n8 = Nat8.fromNat(n);
        n8
    };

    /// #Int
    /// Int to Nat
    public func intToNat(int: Int): Nat{
        Int.abs(int);
    };
}