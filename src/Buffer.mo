import Buffer "mo:base/Buffer";
import Buffer "mo:base/Buffer";

module{
    public func fromArray<T>(array: [T]): Buffer.Buffer<T>{
        let buf = Buffer.Buffer<T>(array.size());

        for item in arr.vals(){
            buf.push(item);
        };

        buf
    };
}