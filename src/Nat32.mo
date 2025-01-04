import Option "mo:base/Option";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Nat32 "mo:base/Nat32";
import Nat64 "mo:base/Nat64";

import NatModule "Nat";

module Nat32Module {

    public let MIN : Nat32 = 0;
    public let MAX : Nat32 = 0xffffffff;

    public func fromText(text : Text) : Nat32 {
        Nat32.fromNat(NatModule.fromText(text));
    };

    public func parse(text : Text) : ?Nat32 {
        Option.map(NatModule.parse(text), Nat32.fromNat);
    };

    public func toBytes(n : Nat32) : [Nat8] {
        NatModule.toBytes(Nat32.toNat(n), 4);
    };

    public func toLeBytes(n: Nat32) : [Nat8] {
        NatModule.toLeBytes(Nat32.toNat(n), 4);
    };

    public func divCeil(num : Nat32, divisor : Nat32) : Nat32 {
        (num + (divisor - 1)) / divisor;
    };

    public func toNat8(x : Nat32) : Nat8 {
        Nat8.fromNat(Nat32.toNat(x));
    };

    public func toNat16(x : Nat32) : Nat16 {
        Nat16.fromNat(Nat32.toNat(x));
    };

    public func toNat64(x : Nat32) : Nat64 {
        Nat64.fromNat(Nat32.toNat(x));
    };
};
