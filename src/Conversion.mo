import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";

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
}