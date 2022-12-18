import Deque "mo:base/Deque";
import Iter "mo:base/Iter";

module {
    public func get<A>(deque : Deque.Deque<A>, size : Nat, index : Nat) : ?A {
        if (index < size / 2) {
            getFromFront(deque, index);
        } else {
            getFromBack(deque, (size - index - 1) : Nat);
        };
    };

    public func getFromFront<A>(dq : Deque.Deque<A>, index : Nat) : ?A {
        var deque = dq;
        var i = 0;

        while (i < index) {
            switch (Deque.popFront(deque)) {
                case (?(val, next)) {
                    deque := next;
                    i := i + 1;
                };
                case (_) return null;
            };
        };

        switch (Deque.popFront(deque)) {
            case (?(val, _)) ?val;
            case (_) null;
        };
    };

    public func getFromBack<A>(dq : Deque.Deque<A>, index : Nat) : ?A {
        var deque = dq;
        var i = 0;

        while (i < index) {
            switch (Deque.popBack(deque)) {
                case (?(next, val)) {
                    deque := next;
                    i := i + 1;
                };
                case (_) return null;
            };
        };

        switch (Deque.popBack(deque)) {
            case (?(_, val)) ?val;
            case (_) null;
        };
    };

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
