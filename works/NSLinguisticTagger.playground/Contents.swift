//: Playground - noun: a place where people can play

import Foundation

let string = "このプログラムはSwiftで書かれています。"
var tokens = [String]()
string.enumerateLinguisticTagsInRange(
    string.startIndex..<string.endIndex,
    scheme: NSLinguisticTagSchemeTokenType,
    options: [.OmitWhitespace, .OmitPunctuation, .JoinNames],
    orthography: nil) { (tag, tokenRange, sentenceRange, stop) in
        let token = string.substringWithRange(tokenRange)
        tokens.append(token)
}
tokens.joinWithSeparator("|") // この|プログラム|は|Swift|で|書|か|れ|て|い|ます

