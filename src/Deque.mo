import Deque "mo:base/Deque";
import Iter "mo:base/Iter";

module {
    public func fromArray<A>(values : [A]) : Deque.Deque<A> {
        var deque = Deque.empty<A>();

        appendArray(deque, values);
    };

    public func appendArray<A>(dq : Deque.Deque<A>, values : [A]) : Deque.Deque<A> {
        var deque = dq;

        for (val in values.vals()) {
            deque := Deque.pushBack(deque, val);
        };

        deque;
    };

    public func prependArray<A>(dq : Deque.Deque<A>, values : [A]) : Deque.Deque<A> {
        var deque = dq;

        for (val in values.vals()) {
            deque := Deque.pushFront(deque, val);
        };

        deque;
    };

    public func toIter<A>(deque : Deque.Deque<A>) : Iter.Iter<A> {
        var iter = deque;

        object {
            public func next() : ?A {
                switch (Deque.popFront(iter)) {
                    case (?(val, next)) {
                        iter := next;
                        ?val;
                    };
                    case (null) null;
                };
            };
        };
    };

    public func toArray<A>(deque : Deque.Deque<A>) : [A] {
        Iter.toArray(
            toIter(deque),
        );
    };
};
