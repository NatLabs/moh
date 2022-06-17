import Array "mo:base/Array";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Option "mo:base/Option";
import Result "mo:base/Result";
import Text "mo:base/Text";

import Hex "mo:encoding/Hex";
import IntFmt "mo:fmt/Int";
import NatFmt "mo:fmt/Nat";

import CharModule "./Char";
import IterModule "./Iter";

module{
    /// Percent encoding for escaping special characters and replacing 
    /// them with their hex value and the percent symbol as a prefix - `%xx`
    public func percentEncoding(t: Text): Text{
        var encoded = "";

        for (c in t.chars()){
            let cAsText =  Char.toText(c);
            if (Text.contains(cAsText, matchAny("'()*-._~")) or Char.isAlphabetic(c) or Char.isDigit(c) ){
                encoded := encoded # Char.toText(c);
            }else{
                let hex = Hex.encodeByte(charToNat8(c));
                encoded := encoded # "%" # hex;
            };
        };
        encoded
    };

    /// Decodes Percent Encoded text
    public func percentDecoding(t: Text): ?Text{
        let iter = Text.split(t, #char '%');
        var decodedURI = Option.get(iter.next(), "");

        for (sp in iter){
            let hex = subText(sp, 0, 2);
            
            switch(Hex.decode(hex)){
                case(#ok(symbols)){
                    let char = (nat8ToChar(symbols[0]));
                    decodedURI := decodedURI # Char.toText(char) # 
                                Text.trimStart(sp, #text hex);
                };
                case(_){
                   return null;
                };
            };

        };

        ?decodedURI
    };

    /// Pads a given text to the start and end and returns the padded text
    public func pad(text: Text, padText: Text): Text{
        padEnd(padStart(text, padText), padText)
    };

    /// Pads the start of the text with the given padText
    public func padStart(text: Text, padText: Text): Text{
        padText # text
    };

    /// Pads the end of the text with the given padText
    public func padEnd(text: Text, padText: Text): Text{
        text # padText
    };

    /// Parses a given text as a number and returns a signed (Int) number
    public func parseInt(text: Text, base: Nat): Result.Result<Int, Text> {
        IntFmt.Parse(text, base)
    };

    /// Parses a given text as a number and returns an unsigned (Nat) number
    public func parseNat(text: Text, base: Nat): Result.Result<Nat, Text> {
        NatFmt.Parse(text, base)
    };

    /// Repeat a specified text `n` number of times
    ///
    /// #### Examples 
    /// ```
    ///     MoH.repeat("*", 3) // "***"
    /// ```
    
    public func repeat(text: Text, n: Nat): Text {
        let repeatingIter = IterModule.repeat<Text>(text, n);
        Text.join("", repeatingIter)
    };

    /// Reverse a text
    public func reverse(text: Text): Text {
        let arr = Iter.toArray<Char>(text.chars());

        var i = arr.size();

        let reversedIter = {
            next = func(): ?Char{
                if (i == 0){
                    null
                }else{
                    i := i - 1;
                    ?arr[i]
                };
            };
        };

        IterModule.toText(reversedIter)
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
    public func subText(value : Text, indexStart: Nat, indexEnd : Nat) : Text {
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

    /// Converts all the characters to lowercase
    public func toLowercase(text: Text): Text{
        var lowercase = "";

        for (c in text.chars()){
            lowercase:= lowercase # Char.toText(CharModule.toLowercase(c));
        };

        return lowercase;
    };

    /// Converts all the characters to uppercase
    public func toUppercase(text: Text): Text{
        var lowercase = "";

        for (c in text.chars()){
            lowercase:= lowercase # Char.toText(CharModule.toUppercase(c));
        };

        return lowercase;
    };

    /// Splits whitespace in the given text and retrieves all the words in it
    public func words(text: Text): Iter.Iter<Text>{
        Text.tokens(text, #char ' ')
    };

    /// Split the given text at the end of every line
    /// Works for texts that end with '\n', '\r' or '\r\n'
    public func lines(text: Text): Iter.Iter<Text>{
        let arr = Iter.toArray(Text.split(text, matchAny("\r\n")));

        if (arr.size() > 1){
            arr.vals()
        }else{
            Text.split(text, #text("\r\n"))
        }
    };

    func matchAny(text: Text): Text.Pattern{
        func pattern(c: Char): Bool{
            Text.contains(text, #char c)
        };

        return #predicate pattern;
    };

    func nat8ToChar(n8: Nat8): Char{
        let n = Nat8.toNat(n8);
        let n32 = Nat32.fromNat(n);
        Char.fromNat32(n32);
    };

    func charToNat8(char: Char): Nat8{
        let n32 = Char.toNat32(char);
        let n = Nat32.toNat(n32);
        let n8 = Nat8.fromNat(n);
    };
}