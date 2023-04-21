import Option "mo:base/Option";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";

import NatModule "Nat";

module Nat8Module {

    public func fromText(text : Text) : Nat8 {
        Nat8.fromNat(NatModule.fromText(text));
    };

    public func parse(text : Text) : ?Nat8 {
        Option.map(NatModule.parse(text), Nat8.fromNat);
    };

    public func divCeil(num : Nat8, divisor : Nat8) : Nat8 {
        num + (num - 1) / divisor;
    };

    // Conversions
    public func toNat16(n : Nat8) : Nat16 {
        Nat16.fromNat(Nat8.toNat(n));
    };

    public func toNat32(n : Nat8) : Nat32 {
        Nat32.fromNat(Nat8.toNat(n));
    };

    public func toNat64(n : Nat8) : Nat64 {
        Nat64.fromNat(Nat8.toNat(n));
    };
};
