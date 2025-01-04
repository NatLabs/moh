import Order "mo:base/Order";

module {
    public func reverse<A>(fn : (A, A) -> Order.Order) : (A, A) -> Order.Order {
        func(a : A, b : A) : Order.Order {
            switch (fn(a, b)) {
                case (#less) #greater;
                case (#equal) #equal;
                case (#greater) #less;
            };
        };
    };
};
