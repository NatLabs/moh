import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Text "mo:base/Text";

import CharModule "Char";
import { Match } "Text";
import It "mo:itertools/Iter";

module {
    public func toHex(blob : Blob) : Text {
        let raw_hex = debug_show (blob);

        Text.replace(raw_hex, Match.anyCharInText("\"\\"), "");
    };

    public func fromHex(raw_hex : Text) : Blob {
        let hex = Text.replace(raw_hex, Match.anyChar(['\"', '\\']), "");

        let size = hex.size();

        if (size % 2 != 0) {
            Debug.trap("Hex string must have an even number of characters");
        };

        let arr = Array.init<Nat8>(size / 2, 0);

        for ((i, tuple) in It.enumerate(It.tuples(hex.chars()))) {
            let (a, b) = tuple;
            arr[i] := (CharModule.toHexDigit(a) << 4) + CharModule.toHexDigit(b);
        };

        Blob.fromArray(Array.freeze(arr));
    };

    public func toBuffer(blob : Blob) : Buffer.Buffer<Nat8> {
        let buffer = Buffer.Buffer<Nat8>(blob.size());

        for (byte in blob.vals()) {
            buffer.add(byte);
        };

        buffer;
    };

    public func concat(blobs : [Blob]) : Blob {
        var total_size = 0;

        var i = 0;
        while (i < blobs.size()) {
            total_size += blobs[i].size();
            i += 1;
        };

        let nested_bytes = Array.tabulate(
            blobs.size(),
            func(i : Nat) : [Nat8] {
                Blob.toArray(blobs[i]);
            },
        );

        var j = 0;

        let bytes : [Nat8] = Array.tabulate(
            total_size,
            func(i : Nat) : Nat8 {
                if (i == nested_bytes[j].size()) {
                    j += 1;
                };

                nested_bytes[j][i];
            },
        );

        Blob.fromArray(bytes);
    };
};
