import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

import ActorSpec "./utils/ActorSpec";
import MoH "../src";

let {
    assertTrue;
    assertFalse;
    assertAllTrue;
    describe;
    it;
    skip;
    pending;
    run;
} = ActorSpec;

let success = run([
    describe(
        "Array fns",
        [

            describe(
                "binary_search",
                [
                    it(
                        "Find index of element in array",
                        do {
                            let arr = [1, 2, 3, 4, 5];

                            assertAllTrue([
                                MoH.Array.binary_search<Nat>(arr, 2, Nat.compare) == #ok(1),
                                MoH.Array.binary_search<Nat>(arr, 5, Nat.compare) == #ok(4),
                            ]);
                        },
                    ),
                    it(
                        "Find the sorted index of an element not in the array",
                        do {
                            let arr = [1, 5, 8, 10, 25];

                            assertAllTrue([
                                MoH.Array.binary_search<Nat>(arr, 7, Nat.compare) == #err(2),
                                MoH.Array.binary_search<Nat>(arr, 30, Nat.compare) == #err(5),
                            ]);
                        },
                    ),
                ],
            ),
            it(
                "chunks",
                do {
                    let arr = [1, 2, 3, 4, 5];
                    let result = MoH.Array.chunk<Nat>(arr, 2);

                    Debug.print(debug_show result);

                    assertTrue(result == [[1, 2], [3, 4], [5]]);
                },
            ),

        ],
    ),

]);

if (success == false) {
    Debug.trap("Tests failed");
} else {
    Debug.print("\1b[23;45;64m Success!");
};
