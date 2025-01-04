import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

module {
    type Iter<A> = Iter.Iter<A>;
    type Buffer<A> = Buffer.Buffer<A>;

    public func swap<T>(buf : Buffer<T>, a : Nat, b : Nat) {
        let tmp = buf.get(a);
        buf.put(a, buf.get(b));
        buf.put(b, tmp);
    };

    public func range<T>(buf: Buffer<T>, start: Nat, len: Nat) : Iter<T>{
        if (start >= buf.size() or start + len > buf.size()){
            Debug.trap("Mo.Buffer: range out of bounds");
        };

        Iter.map(
            Iter.range(start + 1, start + len),
            func (i: Nat) : T  = buf.get(i - 1)
        );        
    };

    public func reverse<T>(buf : Buffer<T>) {
        var i = 0;
        var j = (buf.size() - 1) : Nat;
        while (i < j) {
            swap(buf, i, j);
            i += 1;
            j -= 1;
        };
    };

    public func swapRemove<T>(buf : Buffer<T>, i : Nat) : ?T {
        swap(buf, i, (buf.size() - 1) : Nat);
        buf.removeLast();
    };
};
