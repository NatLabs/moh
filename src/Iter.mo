import Iter "mo:base/Iter";
import List "mo:base/List";

module{
    // /// Might depracate
    public func chunk<A>(iter: Iter.Iter<A>, size: Nat): Iter.Iter<[A]>{
        assert size > 0;

        object{
            public func next(): ?[A]{
                var i = 0;
                var list = List.nil<A>();

                label l while (i < size){
                    switch(iter.next()){
                        case (?val){
                            list:= List.push(val, list);
                            i:= i + 1;
                        };
                        case (_){
                            break l;
                        };
                    };
                };

                if (List.isNil(list)){
                    null
                }else{
                    ?List.toArray(list)
                }
            }
        }
    };

    /// Takes in the iter value and returns a tuple with the 
    /// index of the value included
    /// val -> (index, val)
    public func enumerate<A>(iter: Iter.Iter<A> ): Iter.Iter<(Nat, A)> {
        var i =0;
        return object{
            public func next ():?(Nat, A) {
                let nextVal = iter.next();

                switch nextVal {
                    case (?v) {
                        let val = ?(i, v);
                        i+= 1;

                        return val;
                    };
                    case (_) null;
                };
            };
        };
    };

    /// Zips two iterators into one iterator of tuples 
    /// a -> b -> (a, b)
    /// > Note: the length of the iterator is equal to the length 
    /// of the shorter input iterator
    public func zip<A, B>(a: Iter.Iter<A>, b:Iter.Iter<B>): Iter.Iter<(A, B)>{
        object{
            public func next(): ?(A, B){
                switch(a.next(), b.next()){
                    case(?valueA, ?valueB) ?(valueA, valueB);
                    case(_, _) null;
                }
            }
        }
    };
}