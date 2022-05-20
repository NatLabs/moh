import ArrayModule "Array";
import BoolModule "./Bool";
import CharModule "./Char";
import IterModule "./Iter";
import NatModule "Nat";
import TextModule "./Text";
module {

  public let {
    any; 
    all; 
    chunk; 
    zip
  } =  ArrayModule;

  public let {
    boolToNat
  } = BoolModule;

  public let {
    toLowercase = charToLowercase; 
    toUppercase = charToUppercase;
  } = CharModule;

  public let {
    isPrime
  } = NatModule;

  public let {
    percentDecoding;
    percentEncoding;
    toLowercase; 
    toUppercase;
    repeat;
    subText;
    words;
    lines;
  } = TextModule;

  /// Iter fns
  public let {
    enumerate; 
    zip: zipIter
  } =  IterModule;
};
