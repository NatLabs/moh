import Option "mo:base/Option";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";

import NatModule "Nat";

module Nat32Module {

    public func fromText(text : Text) : Nat32 {
        Nat32.fromNat(NatModule.fromText(text));
    };

    public func parse(text : Text) : ?Nat32 {
        Option.map(NatModule.parse(text), Nat32.fromNat);
    };

    public func toNat8(x : Nat32) : Nat8 {
        Nat8.fromNat(Nat32.toNat(x));
    };
};
