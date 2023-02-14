import Array "mo:base/Array";
import Deque "mo:base/Deque";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Func "mo:base/Func";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Result "mo:base/Result";
import Text "mo:base/Text";

import Hex "mo:encoding/Hex";

import ArrayModule "./Array";
import CharModule "./Char";

import Itertools "mo:itertools/Iter";
import Deiter "mo:itertools/Deiter";

module {
    /// Percent encoding for escaping special characters and replacing
    /// them with their hex value and the percent symbol as a prefix - `%xx`
    public func encodeURL(t : Text) : Text {
        var encoded = "";

        for (c in t.chars()) {
            let cAsText = Char.toText(c);
            let isSpecialChar = Text.contains(
                cAsText,
                // Match.anyChar(['\'', '(', ')', '*', '-', '.', '_', '~']),
                Match.anyCharInText("'()*-._~"),
            );

            if (isSpecialChar or Char.isAlphabetic(c) or Char.isDigit(c)) {
                encoded := encoded # Char.toText(c);
            } else {
                let hex = Hex.encodeByte(charToNat8(c));
                encoded := encoded # "%" # hex;
            };
        };
        encoded;
    };

    /// Decodes Percent Encoded text
    public func decodeURL(t : Text) : ?Text {
        let iter = Text.split(t, #char '%');
        var decodedURI = Option.get(iter.next(), "");

        for (sp in iter) {
            let hex = subText(sp, 0, 2);

            switch (Hex.decode(hex)) {
                case (#ok(symbols)) {
                    let char = (nat8ToChar(symbols[0]));
                    decodedURI := decodedURI # Char.toText(char) # Text.trimStart(sp, #text hex);
                };
                case (_) {
                    return null;
                };
            };

        };

        ?decodedURI;
    };

    /// Capitalize the first letter and convert the rest to lowercase
    public func capitalize(text : Text) : Text {
        let chars = text.chars();

        switch (chars.next()) {
            case (?c) {
                let first_char = Char.toText(CharModule.toUppercase(c));

                first_char # joinChars("", Iter.map(chars, CharModule.toLowercase));
            };
            case (null) { "" };
        };
    };

    /// Capitalize the first letter of each word in a text
    public func capitalizeWords(text : Text, delim : Text.Pattern) : Text {
        let iter = Iter.map(
            Text.split(text, delim),
            func(word : Text) : Text {
                capitalize(word);
            },
        );

        switch (delim) {
            case (#char c) {
                Text.join(Char.toText(c), iter);
            };
            case (#text t) {
                Text.join(t, iter);
            };
            case (#predicate p) {
                // todo
                "";
            };
        };
    };

    public func format(fstring : Text, args : [Text]) : Text {
        var result : Text = "";
        let fstr = Iter.toArray(Text.split(fstring, #text "{}"));

        if (fstr.size() != args.size() + 1) {
            Debug.trap("Text.format: Invalid number of arguments");
        };

        for (i in Iter.range(0, args.size() - 1)) {
            result := result # fstr[i] # (if (i < args.size()) { args[i] } else { "" });
        };

        return result # fstr[args.size()];
    };

    /// Returns the index of the first occurrence of a pattern in a text
    public func index(text : Text, pattern : Text.Pattern) : ?Nat {
        indexFrom(text, pattern, 0);
    };

    /// Returns the index of the first occurrence of a pattern in a text after a given start index
    public func indexFrom(text : Text, pattern : Text.Pattern, start : Nat) : ?Nat {
        let iter = Text.split(text, pattern);
        var index = 0;

        for (t in iter) {
            if (index >= start) {
                return ?index;
            };
            index += t.size();
        };

        null;
    };

    public func joinChars(delim : Text, chars : Iter.Iter<Char>) : Text {
        Text.join(
            delim,
            Iter.map(chars, Char.toText),
        );
    };

    /// Pads a given text to the start and end and returns the padded text
    public func pad(text : Text, padText : Text) : Text {
        padEnd(padStart(text, padText), padText);
    };

    /// Pads the start of the text with the given padText
    public func padStart(text : Text, padText : Text) : Text {
        padText # text;
    };

    /// Pads the end of the text with the given padText
    public func padEnd(text : Text, padText : Text) : Text {
        text # padText;
    };

    /// Repeat a specified text `n` number of times
    ///
    /// #### Examples
    /// ```
    ///     Mo.repeat("*", 3) // "***"
    /// ```
    public func repeat(text : Text, n : Nat) : Text {
        var repeatedText = text;

        for (_ in Iter.range(2, n)) {
            repeatedText #= text;
        };

        repeatedText;
    };

    /// Reverse a text
    public func reverse(text : Text) : Text {
        var reversed_text = "";

        for (c in text.chars()) {
            reversed_text := Char.toText(c) # reversed_text;
        };

        reversed_text;
    };

    /// Solution by user 'Motokoder' from the dfinity forum
    /// https://forum.dfinity.org/t/subtext-substring-function-in-motoko/11838
    ///
    /// Returns a text starting from `indexStart` to `indexEnd` but
    /// not including the char at that index
    /// #### Example
    /// ```mo
    ///     subText("Motokoder", 4, 9)  // "koder"
    /// ```
    ///
    public func subText(value : Text, indexStart : Nat, indexEnd : Nat) : Text {
        if (indexStart == 0 and indexEnd >= value.size()) {
            return value;
        };
        if (indexStart >= value.size()) {
            return "";
        };

        var result : Text = "";
        var i : Nat = 0;
        label l for (c in value.chars()) {
            if (i >= indexStart and i < indexEnd) {
                result := result # Char.toText(c);
            };
            if (i == indexEnd) {
                break l;
            };
            i += 1;
        };

        result;
    };

    public func stripStart(text : Text, prefix : Text.Pattern) : Text {
        switch (Text.stripStart(text, prefix)) {
            case (?t) t;
            case (_) text;
        };
    };

    public func stripEnd(text : Text, suffix : Text.Pattern) : Text {
        switch (Text.stripEnd(text, suffix)) {
            case (?t) t;
            case (_) text;
        };
    };

    /// Converts all the characters to lowercase
    public func toLowercase(text : Text) : Text {
        Text.map(text, CharModule.toLowercase);
    };

    /// Converts all the characters to uppercase
    public func toUppercase(text : Text) : Text {
        Text.map(text, CharModule.toUppercase);
    };

    /// Splits whitespace in the given text and retrieves all the words in it
    public func words(text : Text) : Iter.Iter<Text> {
        Text.tokens(text, #char ' ');
    };

    /// Split the given text at the end of every line
    /// Works for texts that end with '\n', '\r' or '\r\n'
    public func lines(text : Text) : Iter.Iter<Text> {
        let arr = Iter.toArray(Text.split(text, Match.anyChar(['\r', '\n'])));

        if (arr.size() > 1) {
            arr.vals();
        } else {
            Text.split(text, #text("\r\n"));
        };
    };

    /// Module for creating Text Patterns
    public module Match {
        /// Matches a single character from the given char array
        public func anyChar(charArray : [Char]) : Text.Pattern {
            func pattern(c1 : Char) : Bool {
                Itertools.any(
                    charArray.vals(),
                    func(c2 : Char) : Bool { c1 == c2 },
                );
            };

            return #predicate pattern;
        };

        /// Matches any character in the given text
        /// > Replaces an array of characters in `anyChar` with a single text argument
        public func anyCharInText(chars : Text) : Text.Pattern {
            func pattern(c : Char) : Bool {
                Text.contains(chars, #char c);
            };

            return #predicate pattern;
        };
    };

    func nat8ToChar(n8 : Nat8) : Char {
        let n = Nat8.toNat(n8);
        let n32 = Nat32.fromNat(n);
        Char.fromNat32(n32);
    };

    func charToNat8(char : Char) : Nat8 {
        let n32 = Char.toNat32(char);
        let n = Nat32.toNat(n32);
        let n8 = Nat8.fromNat(n);
    };
};
