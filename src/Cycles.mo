import ExperimentalCycles "mo:base/ExperimentalCycles";
import Iter "mo:base/Iter";

module Cycles {
    public let CREATE_CANISTER = 100_000_000_000;

    public func cost(fn : () -> ()) : Nat  {
        var prev_balance = ExperimentalCycles.balance();
        fn();
        (prev_balance - ExperimentalCycles.balance()) : Nat;
    };

    public func multiRunCost(n: Nat, fn : () -> ()) : Nat  {
        var cycles = 0;

        for (_ in Iter.range(1, n)) {
            cycles += cost(fn);
        };

        cycles;
    };
};