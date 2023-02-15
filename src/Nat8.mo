import Option "mo:base/Option";
import Nat8 "mo:base/Nat8";

import NatModule "Nat";

module Nat8Module {

    public func fromText(text : Text) : Nat8 {
        Nat8.fromNat(NatModule.fromText(text));
    };

    public func parse(text : Text) : ?Nat8 {
        Option.map(NatModule.parse(text), Nat8.fromNat);
    };

};
