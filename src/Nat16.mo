import Option "mo:base/Option";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";

import NatModule "Nat";

module Nat16Module {

    public func fromText(text : Text) : Nat16 {
        Nat16.fromNat(NatModule.fromText(text));
    };

    public func parse(text : Text) : ?Nat16 {
        Option.map(NatModule.parse(text), Nat16.fromNat);
    };

    public func toBytes(n : Nat16) : [Nat8] {
        NatModule.toBytes(Nat16.toNat(n), 2);
    };

    public func toLeBytes(n : Nat16) : [Nat8] {
        NatModule.toLeBytes(Nat16.toNat(n), 2);
    };

    public func toNat8(x : Nat16) : Nat8 {
        Nat8.fromNat(Nat16.toNat(x));
    };


};
