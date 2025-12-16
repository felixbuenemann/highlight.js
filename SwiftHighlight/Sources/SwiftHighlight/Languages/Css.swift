// Manually ported from highlight.js
// Language: css

import Foundation

/// CSS language definition
public func cssLanguage(_ hljs: HighlightJS) -> Language {
    let lang = Language()
    lang.name = "CSS"
    lang.aliases = ["css"]
    lang.caseInsensitive = true
    lang.illegal = .regex("[=/|'\\$]")

    lang.keywords = .grouped([
        "keyframePosition": "from to" as Any
    ])

    // Strings
    let STRING = Mode()
    STRING.scope = .single("string")
    STRING.variants = [
        {
            let m = Mode()
            m.begin = .regex("'")
            m.end = .regex("'")
            m.contains = [.mode(CommonModes.BACKSLASH_ESCAPE())]
            return m
        }(),
        {
            let m = Mode()
            m.begin = .regex("\"")
            m.end = .regex("\"")
            m.contains = [.mode(CommonModes.BACKSLASH_ESCAPE())]
            return m
        }()
    ]

    // Numbers with units
    let CSS_NUMBER = Mode()
    CSS_NUMBER.scope = .single("number")
    CSS_NUMBER.begin = .regex("[+-]?(\\d+(\\.\\d+)?|\\.\\d+)(%|[a-z]+)?")
    CSS_NUMBER.relevance = 0

    // Color values
    let HEX_COLOR = Mode()
    HEX_COLOR.scope = .single("number")
    HEX_COLOR.begin = .regex("#([0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\\b")

    // ID selector
    let SELECTOR_ID = Mode()
    SELECTOR_ID.scope = .single("selector-id")
    SELECTOR_ID.begin = .regex("#[A-Za-z0-9_-]+")
    SELECTOR_ID.relevance = 0

    // Class selector
    let SELECTOR_CLASS = Mode()
    SELECTOR_CLASS.scope = .single("selector-class")
    SELECTOR_CLASS.begin = .regex("\\.[A-Za-z0-9_-]+")
    SELECTOR_CLASS.relevance = 0

    // Attribute selector
    let SELECTOR_ATTR = Mode()
    SELECTOR_ATTR.scope = .single("selector-attr")
    SELECTOR_ATTR.begin = .regex("\\[")
    SELECTOR_ATTR.end = .regex("\\]")
    SELECTOR_ATTR.contains = [.mode(STRING)]

    // Pseudo selectors
    let SELECTOR_PSEUDO = Mode()
    SELECTOR_PSEUDO.scope = .single("selector-pseudo")
    SELECTOR_PSEUDO.begin = .regex("::?[a-zA-Z-]+")

    // Tag selectors
    let SELECTOR_TAG = Mode()
    SELECTOR_TAG.scope = .single("selector-tag")
    SELECTOR_TAG.begin = .regex("\\b(a|abbr|address|article|aside|audio|b|blockquote|body|button|canvas|caption|cite|code|col|colgroup|data|datalist|dd|del|details|dfn|dialog|div|dl|dt|em|embed|fieldset|figcaption|figure|footer|form|h[1-6]|head|header|hgroup|hr|html|i|iframe|img|input|ins|kbd|label|legend|li|link|main|map|mark|menu|meta|meter|nav|noscript|object|ol|optgroup|option|output|p|param|picture|pre|progress|q|rp|rt|ruby|s|samp|script|section|select|slot|small|source|span|strong|style|sub|summary|sup|table|tbody|td|template|textarea|tfoot|th|thead|time|title|tr|track|u|ul|var|video|wbr)\\b")
    SELECTOR_TAG.relevance = 0

    // Property names
    let PROPERTY = Mode()
    PROPERTY.scope = .single("attribute")
    PROPERTY.begin = .regex("[a-z-]+(?=\\s*:)")

    // Important keyword
    let IMPORTANT = Mode()
    IMPORTANT.scope = .single("meta")
    IMPORTANT.begin = .regex("!important\\b")

    // @ rules
    let AT_RULE = Mode()
    AT_RULE.scope = .single("keyword")
    AT_RULE.begin = .regex("@[a-z-]+")

    // Function calls
    let FUNCTION = Mode()
    FUNCTION.scope = .single("built_in")
    FUNCTION.begin = .regex("[a-z-]+(?=\\()")

    // Comments
    let COMMENT = Mode()
    COMMENT.scope = .single("comment")
    COMMENT.begin = .regex("/\\*")
    COMMENT.end = .regex("\\*/")

    // Vendor prefix
    let VENDOR_PREFIX = Mode()
    VENDOR_PREFIX.begin = .regex("-(webkit|moz|ms|o)-(?=[a-z])")

    // Variable reference
    let VARIABLE = Mode()
    VARIABLE.scope = .single("variable")
    VARIABLE.begin = .regex("var\\(--[a-zA-Z0-9_-]+\\)")

    // CSS variable definition
    let VARIABLE_DEF = Mode()
    VARIABLE_DEF.scope = .single("variable")
    VARIABLE_DEF.begin = .regex("--[a-zA-Z0-9_-]+")

    // Rule block
    let RULE_BLOCK = Mode()
    RULE_BLOCK.begin = .regex("\\{")
    RULE_BLOCK.end = .regex("\\}")
    RULE_BLOCK.contains = [
        .mode(COMMENT),
        .mode(PROPERTY),
        .mode(STRING),
        .mode(HEX_COLOR),
        .mode(CSS_NUMBER),
        .mode(IMPORTANT),
        .mode(FUNCTION),
        .mode(VARIABLE),
        .mode(VARIABLE_DEF)
    ]

    lang.contains = [
        .mode(COMMENT),
        .mode(AT_RULE),
        .mode(SELECTOR_ID),
        .mode(SELECTOR_CLASS),
        .mode(SELECTOR_ATTR),
        .mode(SELECTOR_PSEUDO),
        .mode(SELECTOR_TAG),
        .mode(VENDOR_PREFIX),
        .mode(RULE_BLOCK),
        .mode(STRING),
        .mode(HEX_COLOR),
        .mode(CSS_NUMBER)
    ]

    return lang
}

/// Register css language
public extension HighlightJS {
    func registerCss() {
        registerLanguage("css", definition: cssLanguage)
    }
}
