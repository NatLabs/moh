import ArrayModule "Array";
import BoolModule "./Bool";
import CharModule "./Char";
import IterModule "./Iter";
import NatModule "Nat";
import TextModule "./Text";
import ConstModule "./Const";

module {

  public let Array = ArrayModule;
  public let {
    any; 
    all; 
    chunk; 
    zip
  } =  ArrayModule;

  public let Bool = BoolModule;
  public let {
    boolToNat
  } = BoolModule;

  public let Char = CharModule;
  public let {
    toLowercase = charToLowercase; 
    toUppercase = charToUppercase;
  } = CharModule;

  public let Const = ConstModule;
  public let {
    Nat8_MAX;
    Nat16_MAX;
  } = ConstModule;

  public let Nat = NatModule;
  public let {
    isPrime
  } = NatModule;

  public let Text = TextModule;
  public let {
    percentDecoding;
    percentEncoding;
    parseInt;
    parseNat;
    toLowercase; 
    toUppercase;
    repeat;
    subText;
    words;
    lines;
  } = TextModule;

  public let Iter = IterModule;
  public let {
    enumerate; 
    zip = zipIter
  } =  IterModule;
};
