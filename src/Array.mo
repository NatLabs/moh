import Array "mo:base/Array";
import Iter "mo:base/Iter";
import TrieSet "mo:base/TrieSet";
import Order "mo:base/Order";
import Hash "mo:base/Hash";
import Result "mo:base/Result";


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

    /// Binary Search for the specified value in the sorted array
    /// Return `#ok` with the index of the value if found, 
    /// `#err` otherwise with the value of the index where the
    /// value should be inserted
    ///
    /// #### Examples
    /// ```mo
    ///    var arr = [2, 5, 1, 9, 2, 3];
    ///    arr:= arrArray.sort(arr);
    ///    MoH.Array.binary_search(arr, 3, Nat.compare) // #ok(2)
    /// ```
    
    public func binary_search<A>(arr:[A], value: A, cmp: (A, A)-> Order.Order): Result.Result<Nat, Nat> {

        if (arr.size() == 0){
            return #err(0);
        };

        var low = 0;
        var high = arr.size() - 1;

        while (low <= high) {
            let mid = (low + high) / 2;
            let midValue = arr[mid];

            switch (cmp(midValue, value) ){
                case (#less){ low:= mid + 1; };
                case (#greater){ high:= mid - 1; };
                case (#equal){ return #ok(mid); };
            };
        };

        return #err(low);
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