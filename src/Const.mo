import Nat8 "mo:base/Nat8";

module{
    public let Nat8_MIN: Nat8 = 0;
    public let Nat8_MAX: Nat8= 0xff;

    public let Nat16_MIN: Nat16 = 0;
    public let Nat16_MAX: Nat16 = 0xffff;

    public let Nat32_MIN: Nat32 = 0;
    public let Nat32_MAX: Nat32 = 0xffffffff;

    public let Nat64_MIN: Nat64 = 0;
    public let Nat64_MAX: Nat64 = 0xffffffffffffffff;

    public let Int8_MIN: Int8 = -0x80;
    public let Int8_MAX: Int8 = 0x7f;

    public let Int16_MIN: Int16 = -0x8000;
    public let Int16_MAX: Int16 = 0x7fff;

    public let Int32_MIN: Int32 = -0x80000000;
    public let Int32_MAX: Int32 = 0x7fffffff;

    public let Int64_MIN: Int64 = -0x8000000000000000;
    public let Int64_MAX: Int64 = 0x7fffffffffffffff;
}