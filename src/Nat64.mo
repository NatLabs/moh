import Option "mo:base/Option";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";

import NatModule "Nat";

module Nat64Module {

    public let MIN : Nat64 = 0;
    public let MAX : Nat64 = 0xffffffffffffffff;

    public func fromText(text : Text) : Nat64 {
        Nat64.fromNat(NatModule.fromText(text));
    };

    public func parse(text : Text) : ?Nat64 {
        Option.map(NatModule.parse(text), Nat64.fromNat);
    };

    public func divCeil(num : Nat64, divisor : Nat64) : Nat64 {
        (num + (divisor - 1)) / divisor;
    };

    public func toBytes(n : Nat64) : [Nat8] {
        NatModule.toBytes(Nat64.toNat(n), 8);
    };

    public func toLeBytes(n:Nat64) : [Nat8] {
        NatModule.toLeBytes(Nat64.toNat(n), 8);
    };

    public func toNat8(x : Nat64) : Nat8 {
        Nat8.fromNat(Nat64.toNat(x));
    };

    public func toNat16(x : Nat64) : Nat16 {
        Nat16.fromNat(Nat64.toNat(x));
    };

    public func toNat32(x : Nat64) : Nat32 {
        Nat32.fromNat(Nat64.toNat(x));
    };

};
