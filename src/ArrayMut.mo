module{
    public func swap<T>(arr:[var T], i: Nat, j: Nat){
        let temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
    };
}