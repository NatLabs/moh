import Nat8 "mo:base/Nat8";

module {
    type Number<A> = {
        MIN : A;
        MAX : A;
    };

    // todo: add cycles limits

    public let Nat8 : Number<Nat8> = {
        MIN = 0;
        MAX = 0xff;
    };

    public let Nat16 : Number<Nat16> = {
        MIN = 0;
        MAX = 0xffff;
    };

    public let Nat32 : Number<Nat32> = {
        MIN = 0;
        MAX = 0xffffffff;
    };

    public let Nat64 : Number<Nat64> = {
        MIN = 0;
        MAX = 0xffffffffffffffff;
    };

    public let Int8 : Number<Int8> = {
        MIN = -0x80;
        MAX = 0x7f;
    };

    public let Int16 : Number<Int16> = {
        MIN = -0x8000;
        MAX = 0x7fff;
    };

    public let Int32 : Number<Int32> = {
        MIN = -0x80000000;
        MAX = 0x7fffffff;
    };

    public let Int64 : Number<Int64> = {
        MIN = -0x8000000000000000;
        MAX = 0x7fffffffffffffff;
    };

    public module Cycles {
        public let CREATE_CANISTER = 100_000_000_000;
    };
};
