// Manually ported from highlight.js
// Language: less

import Foundation

/// Less language definition - CSS preprocessor
public func lessLanguage(_ hljs: HighlightJS) -> Language {
    let lang = Language()
    lang.name = "Less"
    lang.aliases = ["less"]
    lang.caseInsensitive = true
    lang.illegal = .regex("[=>'/<($\"]")

    // Strings
    let SINGLE_STRING = Mode()
    SINGLE_STRING.scope = .single("string")
    SINGLE_STRING.begin = .regex("~?'[^']*'")

    let DOUBLE_STRING = Mode()
    DOUBLE_STRING.scope = .single("string")
    DOUBLE_STRING.begin = .regex("~?\"[^\"]*\"")

    // Numbers with units
    let CSS_NUMBER = Mode()
    CSS_NUMBER.scope = .single("number")
    CSS_NUMBER.begin = .regex("[+-]?(\\d+(\\.\\d+)?|\\.\\d+)(%|em|ex|ch|rem|vw|vh|vmin|vmax|cm|mm|in|pt|pc|px|deg|grad|rad|turn|s|ms|Hz|kHz|dpi|dpcm|dppx)?")
    CSS_NUMBER.relevance = 0

    // Hex colors
    let HEX_COLOR = Mode()
    HEX_COLOR.scope = .single("number")
    HEX_COLOR.begin = .regex("#([0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})\\b")

    // Unicode range
    let UNICODE_RANGE = Mode()
    UNICODE_RANGE.scope = .single("number")
    UNICODE_RANGE.begin = .regex("[Uu]\\+[0-9A-Fa-f][0-9A-Fa-f?]{0,4}(-[0-9A-Fa-f][0-9A-Fa-f]{0,4})?")

    // Less variables
    let VARIABLE = Mode()
    VARIABLE.scope = .single("variable")
    VARIABLE.variants = [
        {
            let m = Mode()
            m.begin = .regex("@@?[\\w-]+\\s*:")
            m.relevance = 15
            return m
        }(),
        {
            let m = Mode()
            m.begin = .regex("@@?[\\w-]+")
            return m
        }(),
        {
            let m = Mode()
            m.begin = .regex("@\\{[\\w-]+\\}")
            return m
        }()
    ]

    // Important
    let IMPORTANT = Mode()
    IMPORTANT.scope = .single("meta")
    IMPORTANT.begin = .regex("!important\\b")

    // Function calls
    let FUNCTION = Mode()
    FUNCTION.scope = .single("built_in")
    FUNCTION.begin = .regex("[\\w-]+(?=\\()")

    // Comments
    let LINE_COMMENT = CommonModes.C_LINE_COMMENT_MODE()
    let BLOCK_COMMENT = CommonModes.C_BLOCK_COMMENT_MODE()

    // ID selector
    let SELECTOR_ID = Mode()
    SELECTOR_ID.scope = .single("selector-id")
    SELECTOR_ID.begin = .regex("#[A-Za-z0-9_-]+|#\\{[\\w-]+\\}")

    // Class selector
    let SELECTOR_CLASS = Mode()
    SELECTOR_CLASS.scope = .single("selector-class")
    SELECTOR_CLASS.begin = .regex("\\.[A-Za-z0-9_-]+|\\.\\{[\\w-]+\\}")
    SELECTOR_CLASS.relevance = 0

    // Attribute selector
    let SELECTOR_ATTR = Mode()
    SELECTOR_ATTR.scope = .single("selector-attr")
    SELECTOR_ATTR.begin = .regex("\\[")
    SELECTOR_ATTR.end = .regex("\\]")
    SELECTOR_ATTR.illegal = .regex("\\$")

    // Pseudo selectors
    let SELECTOR_PSEUDO = Mode()
    SELECTOR_PSEUDO.scope = .single("selector-pseudo")
    SELECTOR_PSEUDO.begin = .regex(":(active|any-link|blank|checked|current|default|defined|dir|disabled|drop|empty|enabled|first|first-child|first-of-type|fullscreen|future|focus|focus-visible|focus-within|has|host|host-context|hover|indeterminate|in-range|invalid|is|lang|last-child|last-of-type|left|link|local-link|not|nth-child|nth-col|nth-last-child|nth-last-col|nth-last-of-type|nth-of-type|only-child|only-of-type|optional|out-of-range|past|placeholder-shown|read-only|read-write|required|right|root|scope|target|target-within|user-invalid|valid|visited|where)")

    let SELECTOR_PSEUDO_ELEMENT = Mode()
    SELECTOR_PSEUDO_ELEMENT.scope = .single("selector-pseudo")
    SELECTOR_PSEUDO_ELEMENT.begin = .regex(":(:)?(after|backdrop|before|cue|cue-region|first-letter|first-line|grammar-error|marker|part|placeholder|selection|slotted|spelling-error)")

    // Tag selectors
    let SELECTOR_TAG = Mode()
    SELECTOR_TAG.scope = .single("selector-tag")
    SELECTOR_TAG.begin = .regex("\\b(a|abbr|address|article|aside|audio|b|blockquote|body|button|canvas|caption|cite|code|dd|del|details|dfn|div|dl|dt|em|fieldset|figcaption|figure|footer|form|h[1-6]|header|hgroup|html|i|iframe|img|input|ins|kbd|label|legend|li|main|mark|menu|nav|object|ol|optgroup|option|p|picture|q|quote|samp|section|select|source|span|strong|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|tr|ul|var|video|defs|g|marker|mask|pattern|svg|switch|symbol|circle|ellipse|image|line|path|polygon|polyline|rect|text|use|textPath|tspan|foreignObject|clipPath)\\b")
    SELECTOR_TAG.relevance = 0

    // Property names
    let PROPERTY = Mode()
    PROPERTY.scope = .single("attribute")
    PROPERTY.begin = .regex("[a-z-]+(?=\\s*:)")

    // Vendor prefix
    let VENDOR_PREFIX = Mode()
    VENDOR_PREFIX.begin = .regex("-(webkit|moz|ms|o)-")

    // CSS variable
    let CSS_VARIABLE = Mode()
    CSS_VARIABLE.scope = .single("attr")
    CSS_VARIABLE.begin = .regex("--[A-Za-z_][A-Za-z0-9_-]*")

    // @ rules
    let AT_RULE = Mode()
    AT_RULE.scope = .single("keyword")
    AT_RULE.begin = .regex("@(import|media|charset|font-face|(-[a-z]+-)?keyframes|supports|document|namespace|page|viewport|host)\\b")

    // Mixin guard
    let MIXIN_GUARD = Mode()
    MIXIN_GUARD.beginKeywords = "when"
    MIXIN_GUARD.endsWithParent = true

    // Inline JS
    let INLINE_JS = Mode()
    INLINE_JS.scope = .single("built_in")
    INLINE_JS.begin = .regex("~?`[^`]*`")

    // Ampersand (parent selector reference)
    let PARENT_SELECTOR = Mode()
    PARENT_SELECTOR.scope = .single("selector-tag")
    PARENT_SELECTOR.begin = .regex("&")

    lang.contains = [
        .mode(LINE_COMMENT),
        .mode(BLOCK_COMMENT),
        .mode(AT_RULE),
        .mode(VARIABLE),
        .mode(SELECTOR_PSEUDO_ELEMENT),
        .mode(SELECTOR_PSEUDO),
        .mode(SELECTOR_ID),
        .mode(SELECTOR_CLASS),
        .mode(SELECTOR_TAG),
        .mode(SELECTOR_ATTR),
        .mode(PARENT_SELECTOR),
        .mode(MIXIN_GUARD),
        .mode(PROPERTY),
        .mode(VENDOR_PREFIX),
        .mode(CSS_VARIABLE),
        .mode(HEX_COLOR),
        .mode(CSS_NUMBER),
        .mode(UNICODE_RANGE),
        .mode(SINGLE_STRING),
        .mode(DOUBLE_STRING),
        .mode(IMPORTANT),
        .mode(INLINE_JS),
        .mode(FUNCTION)
    ]

    return lang
}

/// Register less language
public extension HighlightJS {
    func registerLess() {
        registerLanguage("less", definition: lessLanguage)
    }
}
