import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Text "mo:base/Text";

import ActorSpec "./utils/ActorSpec";
import Mo "../src";

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
        "Text fns",
        [

            describe(
                "Match Module",
                [
                    it(
                        "'hello::world' does not contain any of ['||', ':::']",
                        do {
                            let arr = [1, 2, 3, 4, 5];

                            assertFalse(
                                Text.contains(
                                    "hello::world",
                                    Mo.Text.Match.anyText(["||", ":::"]),
                                ),
                            );
                        },
                    ),
                    it(
                        "'hello::world' matches one of ['||', '::']",
                        do {
                            let arr = [1, 2, 3, 4, 5];

                            assertTrue(
                                Text.contains(
                                    "hello::world",
                                    Mo.Text.Match.anyText(["||", "::"]),
                                ),
                            );
                        },
                    ),
                    it(
                        "'hello::world||model' split at ['||', '::']",
                        do {
                            let arr = [1, 2, 3, 4, 5];
                            let res = Iter.toArray(
                                Text.split(
                                    "hello::world||model",
                                    Mo.Text.Match.anyText(["||", "::"]),
                                ),
                            );

                            Debug.print(debug_show (res));
                            assertTrue(
                                ["hello", "world", "model"] == res,
                            );
                        },
                    ),
                ],
            ),
        ],
    ),

]);

if (success == false) {
    Debug.trap("\1b[46;41mTests failed\1b[0m");
} else {
    Debug.print("\1b[23;42;3m Success!\1b[0m");
};
