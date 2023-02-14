module {
    public func swap<T>(arr : [var T], i : Nat, j : Nat) {
        let temp = arr[i];
        arr[i] := arr[j];
        arr[j] := temp;
    };

    public func reverse<T>(arr : [var T]) {
        var i = 0;
        var j = (arr.size() - 1) : Nat;

        while (i < j) {
            swap(arr, i, j);
            i += 1;
            j -= 1;
        };
    };
};
