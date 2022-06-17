import Float "mo:base/Float";
import Iter "mo:base/Iter";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Buffer "mo:base/Buffer";

import ArrayModule "Array";
import IterModule "Iter";
import Conversion "Conversion";

module{
    public func isPrime(n: Nat): Bool{
        let f = Float.fromInt(n);
        let sqrt = Float.sqrt(f);

        for (i in Iter.range(2, Float.toInt(sqrt))){
            if (n % i == 0){
                return false;
            }
        };

        return n > 1;
    };

    public func toBigEndian(n: Nat): [Nat8]{
        let n64 = Nat64.fromNat(n);
        
        var n_bytes: Nat64 = if (n < 0x80){
            1
        }else if (n < 0x8000){
            2
        }else if (n < 0x80000000){
            3
        }else{
            4
        };

        let buf = Buffer.Buffer<Nat8>(Nat64.toNat(n_bytes));

        while(n_bytes > 0){
            n_bytes -= 1;
            let b = ( n64 >> (n_bytes * 8) ) & 0xff;
            let byte = Nat8.fromNat(Nat64.toNat(b));
            buf.add(byte);
        };

        return buf.toArray();
    };

    public func toLittleEndian(n: Nat):[Nat8]{
        ArrayModule.reverse<Nat8>(toBigEndian(n))
    };

    public func fromBigEndian(bytes: [Nat8]): Nat{
        var n64: Nat64 = 0;

        for ((i, byte) in IterModule.enumerate(bytes.vals())){
            n64 <<= 8 * Nat64.fromNat(i);
            n64 |= Conversion.nat8ToNat64(byte);
        };

        Nat64.toNat(n64)
    };

    public func fromLittleEndian(bytes: [Nat8]): Nat{
        let LE = ArrayModule.reverse<Nat8>(bytes);
        fromBigEndian(LE)
    };
}