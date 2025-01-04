import Array "mo:base/Array";
import Iter "mo:base/Iter";
import TrieSet "mo:base/TrieSet";
import Order "mo:base/Order";
import Hash "mo:base/Hash";
import Result "mo:base/Result";
import Int "mo:base/Int";
import Debug "mo:base/Debug";

import BoolModule "./Bool";

module {

    type Iter<A> = Iter.Iter<A>;

    public func clone<A>(arr : [A]) : [A] {
        Array.tabulate<A>(arr.size(), func(i) { arr[i] });
    };

    /// Splits the array into chunks of specified `size`. If the
    /// array is not evenly divisible by the specified chunk size
    /// then it will return the remainder
    ///
    /// #### Examples
    /// ```mo
    ///     Mo.chunk([1, 2, 3, 4, 5], 2) // [[1, 2], [3, 4], [5]]
    /// ```
    public func chunk<A>(arr : [A], size : Nat) : [[A]] {
        assert size > 0;

        let arrSize = arr.size();
        let totalChunks = arrSize / size + BoolModule.toNat((arrSize % size) > 0);

        Array.tabulate<[A]>(
            totalChunks,
            func(i) {
                if (arrSize >= (size * (i + 1))) {
                    Array.tabulate<A>(size, func(j) { arr[(i * size) + j] });
                } else {
                    Array.tabulate<A>(arrSize % size, func(j) { arr[(i * size) + j] });
                };
            },
        );
    };

    /// Returns the first element in the array if it exists, otherwise returns `null`
    public func first<A>(arr : [A]) : ?A {
        if (arr.size() > 0) {
            ?arr[0];
        } else {
            null;
        };
    };

    /// Returns the last element in the array if it exists, otherwise returns `null`
    public func last<A>(arr : [A]) : ?A {
        if (arr.size() > 0) {
            ?arr[Int.abs(arr.size() - 1)];
        } else {
            null;
        };
    };

    /// Binary Search for the specified value in the sorted array
    /// Return `#ok` with the index of the value if found,
    /// `#err` otherwise with the value of the index where the
    /// value should be inserted
    ///
    /// #### Examples
    /// ```mo
    ///    var arr = [2, 5, 1, 9, 2, 3];
    ///    arr:= arrArray.sort(arr);
    ///    Mo.Array.binary_search(arr, 3, Nat.compare) // #ok(2)
    /// ```
    public func binary_search<A>(arr : [A], value : A, cmp : (A, A) -> Order.Order) : Result.Result<Nat, Nat> {

        if (arr.size() == 0) {
            return #err(0);
        };

        var low = 0;
        var high = (arr.size() - 1) : Nat;

        while (low <= high) {
            let mid = (low + high) / 2;
            let midValue = arr[mid];

            switch (cmp(midValue, value)) {
                case (#less) { low := mid + 1 };
                case (#greater) { high := mid - 1 };
                case (#equal) { return #ok(mid) };
            };
        };

        return #err(low);
    };

    public func range<A>(arr: [A], start : Nat, len : Nat) : Iter<A> {
        if (start >= arr.size() or start + len > arr.size()) {
            Debug.trap("Mo.Array range(): index out of bounds");
        };

        Iter.map(
            Iter.range(start + 1, start + len),
            func(i: Nat) : A = arr.get(i)
        )
    };
    
    public func reverse<A>(arr : [A]) : [A] {
        Array.tabulate<A>(arr.size(), func(i) { arr[arr.size() - i - 1] });
    };

    /// Returns a new array with only unique values
    public func unique<A>(arr : [A], hash : A -> Hash.Hash, isEq : (A, A) -> Bool) : [A] {
        let trieSet = TrieSet.fromArray<A>(arr, hash, isEq);
        TrieSet.toArray<A>(trieSet);
    };

};
