// Manually ported from highlight.js
// Language: scss

import Foundation

/// SCSS language definition - CSS preprocessor with Sass syntax
public func scssLanguage(_ hljs: HighlightJS) -> Language {
    let lang = Language()
    lang.name = "SCSS"
    lang.aliases = ["scss"]
    lang.caseInsensitive = true
    lang.illegal = .regex("[=/|']")

    // SCSS variables
    let VARIABLE = Mode()
    VARIABLE.scope = .single("variable")
    VARIABLE.begin = .regex("\\$[a-zA-Z-][a-zA-Z0-9_-]*")
    VARIABLE.relevance = 0

    // Comments
    let LINE_COMMENT = CommonModes.C_LINE_COMMENT_MODE()
    let BLOCK_COMMENT = CommonModes.C_BLOCK_COMMENT_MODE()

    // Numbers with units
    let CSS_NUMBER = Mode()
    CSS_NUMBER.scope = .single("number")
    CSS_NUMBER.begin = .regex("[+-]?(\\d+(\\.\\d+)?|\\.\\d+)(%|em|ex|ch|rem|vw|vh|vmin|vmax|cm|mm|in|pt|pc|px|deg|grad|rad|turn|s|ms|Hz|kHz|dpi|dpcm|dppx)?")
    CSS_NUMBER.relevance = 0

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
    SELECTOR_ATTR.illegal = .regex("\\$")

    // Tag selectors
    let SELECTOR_TAG = Mode()
    SELECTOR_TAG.scope = .single("selector-tag")
    SELECTOR_TAG.begin = .regex("\\b(a|abbr|address|article|aside|audio|b|blockquote|body|button|canvas|caption|cite|code|dd|del|details|dfn|div|dl|dt|em|fieldset|figcaption|figure|footer|form|h[1-6]|header|hgroup|html|i|iframe|img|input|ins|kbd|label|legend|li|main|mark|menu|nav|object|ol|optgroup|option|p|picture|q|quote|samp|section|select|source|span|strong|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|tr|ul|var|video|defs|g|marker|mask|pattern|svg|switch|symbol|circle|ellipse|image|line|path|polygon|polyline|rect|text|use|textPath|tspan|foreignObject|clipPath)\\b")
    SELECTOR_TAG.relevance = 0

    // Pseudo classes
    let SELECTOR_PSEUDO = Mode()
    SELECTOR_PSEUDO.scope = .single("selector-pseudo")
    SELECTOR_PSEUDO.begin = .regex(":(active|any-link|blank|checked|current|default|defined|dir|disabled|drop|empty|enabled|first|first-child|first-of-type|fullscreen|future|focus|focus-visible|focus-within|has|host|host-context|hover|indeterminate|in-range|invalid|is|lang|last-child|last-of-type|left|link|local-link|not|nth-child|nth-col|nth-last-child|nth-last-col|nth-last-of-type|nth-of-type|only-child|only-of-type|optional|out-of-range|past|placeholder-shown|read-only|read-write|required|right|root|scope|target|target-within|user-invalid|valid|visited|where)")

    // Pseudo elements
    let SELECTOR_PSEUDO_ELEMENT = Mode()
    SELECTOR_PSEUDO_ELEMENT.scope = .single("selector-pseudo")
    SELECTOR_PSEUDO_ELEMENT.begin = .regex(":(:)?(after|backdrop|before|cue|cue-region|first-letter|first-line|grammar-error|marker|part|placeholder|selection|slotted|spelling-error)")

    // Property names
    let PROPERTY = Mode()
    PROPERTY.scope = .single("attribute")
    PROPERTY.begin = .regex("[a-z-]+(?=\\s*:)")

    // Hex colors
    let HEX_COLOR = Mode()
    HEX_COLOR.scope = .single("number")
    HEX_COLOR.begin = .regex("#([0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\\b")

    // Unicode range
    let UNICODE_RANGE = Mode()
    UNICODE_RANGE.scope = .single("number")
    UNICODE_RANGE.begin = .regex("[Uu]\\+[0-9A-Fa-f][0-9A-Fa-f?]{0,4}(-[0-9A-Fa-f][0-9A-Fa-f]{0,4})?")

    // Strings
    let QUOTE_STRING = CommonModes.QUOTE_STRING_MODE()
    let APOS_STRING = CommonModes.APOS_STRING_MODE()

    // Important
    let IMPORTANT = Mode()
    IMPORTANT.scope = .single("meta")
    IMPORTANT.begin = .regex("!important\\b")

    // Function calls
    let FUNCTION = Mode()
    FUNCTION.scope = .single("built_in")
    FUNCTION.begin = .regex("[\\w-]+(?=\\()")

    // CSS variable
    let CSS_VARIABLE = Mode()
    CSS_VARIABLE.scope = .single("attr")
    CSS_VARIABLE.begin = .regex("--[A-Za-z_][A-Za-z0-9_-]*")

    // @ rules - page and font-face
    let AT_PAGE_FONT = Mode()
    AT_PAGE_FONT.begin = .regex("@(page|font-face)")
    AT_PAGE_FONT.keywords = .grouped([
        "keyword": "@page @font-face" as Any
    ])

    // @ rules - general
    let AT_RULE = Mode()
    AT_RULE.begin = .regex("@")
    AT_RULE.end = .regex("[{;]")
    AT_RULE.returnBegin = true
    AT_RULE.keywords = .grouped([
        "keyword": "and or not only" as Any,
        "attribute": "any-hover any-pointer aspect-ratio color color-gamut color-index device-aspect-ratio device-height device-width display-mode forced-colors grid height hover inverted-colors monochrome orientation overflow-block overflow-inline pointer prefers-color-scheme prefers-contrast prefers-reduced-motion prefers-reduced-transparency resolution scan scripting update width min-width max-width min-height max-height" as Any
    ])

    // AT rule keyword
    let AT_KEYWORD = Mode()
    AT_KEYWORD.scope = .single("keyword")
    AT_KEYWORD.begin = .regex("@[a-z-]+")

    // CSS value keywords
    let VALUE_KEYWORDS = Mode()
    VALUE_KEYWORDS.begin = .regex("\\b(whitespace|wait|w-resize|visible|vertical-text|vertical-ideographic|uppercase|upper-roman|upper-alpha|underline|transparent|top|thin|thick|text|text-top|text-bottom|tb-rl|table-header-group|table-footer-group|sw-resize|super|strict|static|square|solid|small-caps|separate|se-resize|scroll|s-resize|rtl|row-resize|ridge|right|repeat|repeat-y|repeat-x|relative|progress|pointer|overline|outside|outset|oblique|nowrap|not-allowed|normal|none|nw-resize|no-repeat|no-drop|newspaper|ne-resize|n-resize|move|middle|medium|ltr|lr-tb|lowercase|lower-roman|lower-alpha|loose|list-item|line|line-through|line-edge|lighter|left|keep-all|justify|italic|inter-word|inter-ideograph|inside|inset|inline|inline-block|inherit|inactive|ideograph-space|ideograph-parenthesis|ideograph-numeric|ideograph-alpha|horizontal|hidden|help|hand|groove|fixed|ellipsis|e-resize|double|dotted|distribute|distribute-space|distribute-letter|distribute-all-lines|disc|disabled|default|decimal|dashed|crosshair|collapse|col-resize|circle|char|center|capitalize|break-word|break-all|bottom|both|bolder|bold|block|bidi-override|below|baseline|auto|always|all-scroll|absolute|table|table-cell)\\b")

    // Value block (after :)
    let VALUE_BLOCK = Mode()
    VALUE_BLOCK.begin = .regex(":")
    VALUE_BLOCK.end = .regex("[;}{]")
    VALUE_BLOCK.relevance = 0
    VALUE_BLOCK.contains = [
        .mode(BLOCK_COMMENT),
        .mode(VARIABLE),
        .mode(HEX_COLOR),
        .mode(CSS_NUMBER),
        .mode(UNICODE_RANGE),
        .mode(QUOTE_STRING),
        .mode(APOS_STRING),
        .mode(IMPORTANT),
        .mode(FUNCTION)
    ]

    lang.contains = [
        .mode(LINE_COMMENT),
        .mode(BLOCK_COMMENT),
        .mode(CSS_NUMBER),
        .mode(SELECTOR_ID),
        .mode(SELECTOR_CLASS),
        .mode(SELECTOR_ATTR),
        .mode(SELECTOR_TAG),
        .mode(SELECTOR_PSEUDO_ELEMENT),
        .mode(SELECTOR_PSEUDO),
        .mode(VARIABLE),
        .mode(VALUE_BLOCK),
        .mode(CSS_VARIABLE),
        .mode(PROPERTY),
        .mode(VALUE_KEYWORDS),
        .mode(AT_PAGE_FONT),
        .mode(AT_KEYWORD),
        .mode(AT_RULE),
        .mode(QUOTE_STRING),
        .mode(APOS_STRING),
        .mode(HEX_COLOR),
        .mode(FUNCTION)
    ]

    return lang
}

/// Register scss language
public extension HighlightJS {
    func registerScss() {
        registerLanguage("scss", definition: scssLanguage)
    }
}
