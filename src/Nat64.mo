import Option "mo:base/Option";
import Nat8 "mo:base/Nat8";
import Nat64 "mo:base/Nat64";

import NatModule "Nat";

module Nat64Module {

    public func fromText(text : Text) : Nat64 {
        Nat64.fromNat(NatModule.fromText(text));
    };

    public func parse(text : Text) : ?Nat64 {
        Option.map(NatModule.parse(text), Nat64.fromNat);
    };

    public func toNat8(x : Nat64) : Nat8 {
        Nat8.fromNat(Nat64.toNat(x));
    };
};
