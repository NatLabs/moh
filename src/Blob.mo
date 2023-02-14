import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Text "mo:base/Text";

import CharModule "Char";
import { Match } "Text";
import It "mo:itertools/Iter";

module{
    public func toHex(blob: Blob): Text{
        let raw_hex = debug_show(blob);

        Text.replace(raw_hex, Match.anyCharInText("\"\\"), "")
    };

    public func fromHex(raw_hex : Text): Blob{
        let hex = Text.replace(raw_hex, #text("\\"), "");

        let size = hex.size();

        if (size % 2 != 0) {
            Debug.trap("Hex string must have an even number of characters");
        };

        let arr = Array.init<Nat8>(size / 2, 0);

        for ((i, tuple) in It.enumerate(It.tuples(hex.chars()))){
            let (a, b) = tuple;
            arr[i] := (CharModule.toHexDigit(a) << 4) + CharModule.toHexDigit(b);
        };

        Blob.fromArray(Array.freeze(arr));
    };
};