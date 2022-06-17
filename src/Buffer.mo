import Buffer "mo:base/Buffer";

module{
    public func swap<T>(buf: Buffer.Buffer<T>, a: Int, b: Int){
        let tmp = buf.get(a);
        buf.put(a, buf.get(b));
        buf.put(b, tmp);
    };
}