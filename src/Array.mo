import Array "mo:base/Array";
import Iter "mo:base/Iter";
import TrieSet "mo:base/TrieSet";
import Order "mo:base/Order";
import Hash "mo:base/Hash";

import BoolModule "./Bool";
import IterModule "./Iter";

module{
    /// Checks if the predicate returns true for all the array values
    ///
    /// #### Examples
    /// ```mo
    ///     U.all([1, 2, 3], func(a){ a < 4 }) // true
    /// ```
    public func all<A>(arr:[A], predicate: (A)-> Bool ): Bool {
        for (n in arr.vals()) {
            if (predicate(n) == false) {
                return false;
            }
        };

        true
    };

    /// Checks if the predicate returns true for any of the array values
    public func any<A>(arr: [A],  predicate: (A)-> Bool ): Bool {
        for (n in arr.vals()){
            if (predicate(n) == true){
                return true;
            }
        };

        false
    };

    /// Splits the array into chunks of specified `size`. If the 
    /// array is not evenly divisible by the specified chunk size
    /// then it will return the remainder
    /// 
    /// #### Examples
    /// ```mo
    ///     U.chunk([1, 2, 3, 4, 5], 2) // [[1, 2], [3, 4], [5]]
    /// ```
    public func chunk<A>(arr: [A], size: Nat):[[A]]{
        assert size > 0;

        let arrSize = arr.size();
        let totalChunks = arrSize/size + BoolModule.boolToNat((arrSize % size) > 0);

        Array.tabulate<[A]>( totalChunks,
            func(i){
                if (arrSize >= (size * (i + 1))){
                    Array.tabulate<A>(size, func(j){arr[(i * size) + j]})
                }else{
                    Array.tabulate<A>(arrSize % size, func(j){arr[(i * size) + j]})
                }
            }
        )
    };

    /// Returns the largest value in the array
    public func max<A>(arr:[A], cmp: (A, A)-> Order.Order): A {
        assert arr.size() > 0;

        var maxValue = arr[0];

        for (n in arr.vals()){
            switch (cmp(n, maxValue) ){
                case (#greater){ maxValue:= n; };
                case (_) {};
            };
        };

        return maxValue
    };

    /// Returns the smallest value in the array
    public func min<A>(arr:[A], cmp: (A, A)-> Order.Order): A {
        assert arr.size() > 0;

        var minValue = arr[0];

        for (n in arr.vals()){
            switch (cmp(n, minValue) ){
                case (#less){ minValue:= n; };
                case (_) {};
            };
        };

        return minValue
    };

    /// Returns a new array with only unique values
    public func uniq<A>(arr: [A], hash : A -> Hash.Hash, isEq : (A, A) -> Bool): [A]{
        let trieSet = TrieSet.fromArray<A>(arr, hash, isEq);
        TrieSet.toArray<A>(trieSet)
    };

    /// Zips two arrays into an array of tuples
    /// #### Example
    /// [1, 2, 3, 4] -> ['a', 'b', 'c'] -> [(1, 'a'), (2, 'b'), (3, 'c')]
    public func zip<A, B>(a: [A], b:[B]): [(A, B)]{
        let zippedIter = IterModule.zip(a.vals(), b.vals());
        Iter.toArray(zippedIter)
    };

}