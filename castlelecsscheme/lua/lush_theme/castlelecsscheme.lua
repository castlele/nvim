local lush = require('lush')
local hsl = lush.hsl
local hsluv = lush.hsluv

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    TermCursor                                 { gui="reverse", }, -- TermCursor     xxx cterm=reverse gui=reverse
    Directory                                  { fg="cyan", }, -- Directory      xxx ctermfg=159 guifg=Cyan
    NeoTreeDirectoryName                       { Directory }, -- NeoTreeDirectoryName xxx links to Directory
    NeoTreeDirectoryIcon                       { Directory }, -- NeoTreeDirectoryIcon xxx links to Directory
    ErrorMsg                                   { bg="red", fg="white", }, -- ErrorMsg       xxx ctermfg=15 ctermbg=1 guifg=White guibg=Red
    NvimInvalidSpacing                         { ErrorMsg }, -- NvimInvalidSpacing xxx links to ErrorMsg
    IncSearch                                  { gui="reverse", }, -- IncSearch      xxx cterm=reverse gui=reverse
    Search                                     { bg="#adadad", }, -- Search         xxx guibg=#adadad
    CurSearch                                  { Search }, -- CurSearch      xxx links to Search
    QuickFixLine                               { Search }, -- QuickFixLine   xxx links to Search
    Substitute                                 { Search }, -- Substitute     xxx links to Search
    NeoTreePreview                             { Search }, -- NeoTreePreview xxx links to Search
    MoreMsg                                    { gui="bold", fg="seagreen", }, -- MoreMsg        xxx ctermfg=121 gui=bold guifg=SeaGreen
    ModeMsg                                    { gui="bold", }, -- ModeMsg        xxx cterm=bold gui=bold
    LineNr                                     { fg="#69748c", }, -- LineNr         xxx guifg=#69748c
    LineNrAbove                                { LineNr }, -- LineNrAbove    xxx links to LineNr
    LineNrBelow                                { LineNr }, -- LineNrBelow    xxx links to LineNr
    CursorLineNr                               { fg="#feffad", }, -- CursorLineNr   xxx guifg=#feffad
    Question                                   { gui="bold", fg="green", }, -- Question       xxx ctermfg=121 gui=bold guifg=Green
    StatusLine                                 { gui="bold,reverse", }, -- StatusLine     xxx cterm=bold,reverse gui=bold,reverse
    MsgSeparator                               { StatusLine }, -- MsgSeparator   xxx links to StatusLine
    NeoTreeStatusLine                          { StatusLine }, -- NeoTreeStatusLine xxx links to StatusLine
    StatusLineNC                               { gui="reverse", }, -- StatusLineNC   xxx cterm=reverse gui=reverse
    NeoTreeStatusLineNC                        { StatusLineNC }, -- NeoTreeStatusLineNC xxx links to StatusLineNC
    Title                                      { fg="#ff8f8f", }, -- Title          xxx guifg=#ff8f8f
    FloatTitle                                 { Title }, -- FloatTitle     xxx links to Title
    sym"@text.title"                           { Title }, -- @text.title    xxx links to Title
    htmlH1                                     { Title }, -- htmlH1         xxx links to Title
    htmlTitle                                  { Title }, -- htmlTitle      xxx links to Title
    WarningMsg                                 { fg="red", }, -- WarningMsg     xxx ctermfg=224 guifg=Red
    WildMenu                                   { bg="yellow", fg="black", }, -- WildMenu       xxx ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
    Folded                                     { bg="darkgrey", fg="cyan", }, -- Folded         xxx ctermfg=14 ctermbg=242 guifg=Cyan guibg=DarkGrey
    FoldColumn                                 { bg="grey", fg="cyan", }, -- FoldColumn     xxx ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
    CursorLineFold                             { FoldColumn }, -- CursorLineFold xxx links to FoldColumn
    DiffAdd                                    { bg="#43a800", }, -- DiffAdd        xxx guibg=#43a800
    DiffChange                                 { DiffAdd }, -- DiffChange     xxx links to DiffAdd
    DiffDelete                                 { bg="#ff4747", }, -- DiffDelete     xxx guibg=#ff4747
    DiffText                                   { fg="#43a800", }, -- DiffText       xxx guifg=#43a800
    Conceal                                    { bg="darkgrey", fg="lightgrey", }, -- Conceal        xxx ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
    SpellBad                                   { sp="red", gui="undercurl", }, -- SpellBad       xxx ctermbg=9 gui=undercurl guisp=Red
    SpellCap                                   { sp="blue", gui="undercurl", }, -- SpellCap       xxx ctermbg=12 gui=undercurl guisp=Blue
    SpellRare                                  { sp="magenta", gui="undercurl", }, -- SpellRare      xxx ctermbg=13 gui=undercurl guisp=Magenta
    SpellLocal                                 { sp="cyan", gui="undercurl", }, -- SpellLocal     xxx ctermbg=14 gui=undercurl guisp=Cyan
    PmenuSel                                   { bg="darkgrey", }, -- PmenuSel       xxx ctermfg=242 ctermbg=0 guibg=DarkGrey
    PmenuKindSel                               { PmenuSel }, -- PmenuKindSel   xxx links to PmenuSel
    PmenuExtraSel                              { PmenuSel }, -- PmenuExtraSel  xxx links to PmenuSel
    PmenuSbar                                  { bg="grey", }, -- PmenuSbar      xxx ctermbg=248 guibg=Grey
    PmenuThumb                                 { bg="white", }, -- PmenuThumb     xxx ctermbg=15 guibg=White
    TabLine                                    { bg="darkgrey", gui="underline", }, -- TabLine        xxx cterm=underline ctermfg=15 ctermbg=242 gui=underline guibg=DarkGrey
    TabLineSel                                 { gui="bold", }, -- TabLineSel     xxx cterm=bold gui=bold
    TabLineFill                                { gui="reverse", }, -- TabLineFill    xxx cterm=reverse gui=reverse
    CursorColumn                               { bg="grey40", }, -- CursorColumn   xxx ctermbg=242 guibg=Grey40
    ColorColumn                                { bg="#595959", }, -- ColorColumn    xxx guibg=#595959
    CursorLine                                 { ColorColumn }, -- CursorLine     xxx links to ColorColumn
    Whitespace                                 { fg="#393f4c", }, -- Whitespace     xxx guifg=#393f4c
    SpecialKey                                 { Whitespace }, -- SpecialKey     xxx links to Whitespace
    NonText                                    { Whitespace }, -- NonText        xxx links to Whitespace
    WinBar                                     { gui="bold", }, -- WinBar         xxx cterm=bold gui=bold
    WinBarNC                                   { WinBar }, -- WinBarNC       xxx links to WinBar
    Cursor                                     { bg="yellow", fg="yellow", }, -- Cursor         xxx guifg=Yellow guibg=Yellow
    lCursor                                    { bg="fg", fg="bg", }, -- lCursor        xxx guifg=bg guibg=fg
    Normal                                     { bg="#272b34", fg="#dedede", }, -- Normal         xxx guifg=#dedede guibg=#272b34
    VertSplit                                  { Normal }, -- VertSplit      xxx links to Normal
    Pmenu                                      { Normal }, -- Pmenu          xxx links to Normal
    Identifier                                 { Normal }, -- Identifier     xxx links to Normal
    NvimSpacing                                { Normal }, -- NvimSpacing    xxx links to Normal
    NeoTreeNormal                              { Normal }, -- NeoTreeNormal  xxx links to Normal
    dtdTag                                     { Normal }, -- dtdTag         xxx links to Normal
    cssMediaComma                              { Normal }, -- cssMediaComma  xxx links to Normal
    FloatShadow                                { bg="black", blend=80, }, -- FloatShadow    xxx guibg=Black blend=80
    FloatShadowThrough                         { bg="black", blend=100, }, -- FloatShadowThrough xxx guibg=Black blend=100
    RedrawDebugNormal                          { gui="reverse", }, -- RedrawDebugNormal xxx cterm=reverse gui=reverse
    RedrawDebugClear                           { bg="yellow", }, -- RedrawDebugClear xxx ctermbg=11 guibg=Yellow
    RedrawDebugComposed                        { bg="green", }, -- RedrawDebugComposed xxx ctermbg=10 guibg=Green
    RedrawDebugRecompose                       { bg="red", }, -- RedrawDebugRecompose xxx ctermbg=9 guibg=Red
    Error                                      { fg="#ff4747", }, -- Error          xxx guifg=#ff4747
    NvimInvalid                                { Error }, -- NvimInvalid    xxx links to Error
    xmlError                                   { Error }, -- xmlError       xxx links to Error
    xmlCommentError                            { Error }, -- xmlCommentError xxx links to Error
    dtdError                                   { Error }, -- dtdError       xxx links to Error
    htmlError                                  { Error }, -- htmlError      xxx links to Error
    htmlPreError                               { Error }, -- htmlPreError   xxx links to Error
    htmlPreProcAttrError                       { Error }, -- htmlPreProcAttrError xxx links to Error
    javaScriptError                            { Error }, -- javaScriptError xxx links to Error
    vbError                                    { Error }, -- vbError        xxx links to Error
    cssError                                   { Error }, -- cssError       xxx links to Error
    cssBraceError                              { Error }, -- cssBraceError  xxx links to Error
    cssDeprecated                              { Error }, -- cssDeprecated  xxx links to Error
    markdownError                              { Error }, -- markdownError  xxx links to Error
    yamlReservedDirective                      { Error }, -- yamlReservedDirective xxx links to Error
    helpError                                  { Error }, -- helpError      xxx links to Error
    Todo                                       { gui="bold,underline", fg="#feffad", }, -- Todo           xxx cterm=bold,underline gui=bold,underline guifg=#feffad
    sym"@text.todo"                            { Todo }, -- @text.todo     xxx links to Todo
    xmlTodo                                    { Todo }, -- xmlTodo        xxx links to Todo
    dtdTodo                                    { Todo }, -- dtdTodo        xxx links to Todo
    javaScriptCommentTodo                      { Todo }, -- javaScriptCommentTodo xxx links to Todo
    vbTodo                                     { Todo }, -- vbTodo         xxx links to Todo
    yamlTodo                                   { Todo }, -- yamlTodo       xxx links to Todo
    helpNote                                   { Todo }, -- helpNote       xxx links to Todo
    helpWarning                                { Todo }, -- helpWarning    xxx links to Todo
    helpDeprecated                             { Todo }, -- helpDeprecated xxx links to Todo
    helpTodo                                   { Todo }, -- helpTodo       xxx links to Todo
    String                                     { fg="#77c0af", }, -- String         xxx guifg=#77c0af
    Character                                  { String }, -- Character      xxx links to String
    sym"@string"                               { String }, -- @string        xxx links to String
    NvimString                                 { String }, -- NvimString     xxx links to String
    xmlString                                  { String }, -- xmlString      xxx links to String
    xmlCdata                                   { String }, -- xmlCdata       xxx links to String
    htmlString                                 { String }, -- htmlString     xxx links to String
    htmlValue                                  { String }, -- htmlValue      xxx links to String
    htmlPreAttr                                { String }, -- htmlPreAttr    xxx links to String
    javaScriptStringD                          { String }, -- javaScriptStringD xxx links to String
    javaScriptStringS                          { String }, -- javaScriptStringS xxx links to String
    javaScriptStringT                          { String }, -- javaScriptStringT xxx links to String
    javaScriptRegexpString                     { String }, -- javaScriptRegexpString xxx links to String
    vbString                                   { String }, -- vbString       xxx links to String
    cssStringQ                                 { String }, -- cssStringQ     xxx links to String
    cssStringQQ                                { String }, -- cssStringQQ    xxx links to String
    cssAttributeSelector                       { String }, -- cssAttributeSelector xxx links to String
    cssURL                                     { String }, -- cssURL         xxx links to String
    markdownUrlTitle                           { String }, -- markdownUrlTitle xxx links to String
    yamlTagHandle                              { String }, -- yamlTagHandle  xxx links to String
    yamlTagPrefix                              { String }, -- yamlTagPrefix  xxx links to String
    yamlString                                 { String }, -- yamlString     xxx links to String
    helpHyperTextEntry                         { String }, -- helpHyperTextEntry xxx links to String
    helpString                                 { String }, -- helpString     xxx links to String
    helpURL                                    { String }, -- helpURL        xxx links to String
    Constant                                   { fg="#50af99", }, -- Constant       xxx guifg=#50af99
    sym"@constant"                             { Constant }, -- @constant      xxx links to Constant
    sym"@lsp.type.enumMember"                  { Constant }, -- @lsp.type.enumMember xxx links to Constant
    dtdConstant                                { Constant }, -- dtdConstant    xxx links to Constant
    vbConst                                    { Constant }, -- vbConst        xxx links to Constant
    vbDefine                                   { Constant }, -- vbDefine       xxx links to Constant
    cssColor                                   { Constant }, -- cssColor       xxx links to Constant
    cssFunction                                { Constant }, -- cssFunction    xxx links to Constant
    cssKeyFrameProp                            { Constant }, -- cssKeyFrameProp xxx links to Constant
    cssAttr                                    { Constant }, -- cssAttr        xxx links to Constant
    cssPseudoClassLang                         { Constant }, -- cssPseudoClassLang xxx links to Constant
    cssUnicodeRange                            { Constant }, -- cssUnicodeRange xxx links to Constant
    yamlConstant                               { Constant }, -- yamlConstant   xxx links to Constant
    helpConstant                               { Constant }, -- helpConstant   xxx links to Constant
    Number                                     { fg="#dedede", }, -- Number         xxx guifg=#dedede
    Float                                      { Number }, -- Float          xxx links to Number
    sym"@number"                               { Number }, -- @number        xxx links to Number
    NvimNumber                                 { Number }, -- NvimNumber     xxx links to Number
    vbNumber                                   { Number }, -- vbNumber       xxx links to Number
    cssUnitDecorators                          { Number }, -- cssUnitDecorators xxx links to Number
    cssValueInteger                            { Number }, -- cssValueInteger xxx links to Number
    cssValueNumber                             { Number }, -- cssValueNumber xxx links to Number
    cssValueLength                             { Number }, -- cssValueLength xxx links to Number
    cssValueAngle                              { Number }, -- cssValueAngle  xxx links to Number
    cssValueTime                               { Number }, -- cssValueTime   xxx links to Number
    cssValueFrequency                          { Number }, -- cssValueFrequency xxx links to Number
    yamlYAMLVersion                            { Number }, -- yamlYAMLVersion xxx links to Number
    yamlTimestamp                              { Number }, -- yamlTimestamp  xxx links to Number
    yamlInteger                                { Number }, -- yamlInteger    xxx links to Number
    helpNumber                                 { Number }, -- helpNumber     xxx links to Number
    Boolean                                    { fg="#ff66b0", }, -- Boolean        xxx guifg=#ff66b0
    sym"@boolean"                              { Boolean }, -- @boolean       xxx links to Boolean
    javaScriptBoolean                          { Boolean }, -- javaScriptBoolean xxx links to Boolean
    vbBoolean                                  { Boolean }, -- vbBoolean      xxx links to Boolean
    helpBoolean                                { Boolean }, -- helpBoolean    xxx links to Boolean
    Function                                   { fg="#3dcfff", }, -- Function       xxx guifg=#3dcfff
    sym"@function"                             { Function }, -- @function      xxx links to Function
    sym"@method"                               { Function }, -- @method        xxx links to Function
    sym"@lsp.type.decorator"                   { Function }, -- @lsp.type.decorator xxx links to Function
    sym"@lsp.type.function"                    { Function }, -- @lsp.type.function xxx links to Function
    sym"@lsp.type.method"                      { Function }, -- @lsp.type.method xxx links to Function
    xmlTagName                                 { Function }, -- xmlTagName     xxx links to Function
    xmlTag                                     { Function }, -- xmlTag         xxx links to Function
    xmlInlineDTD                               { Function }, -- xmlInlineDTD   xxx links to Function
    xmlDocTypeDecl                             { Function }, -- xmlDocTypeDecl xxx links to Function
    dtdFunction                                { Function }, -- dtdFunction    xxx links to Function
    htmlTag                                    { Function }, -- htmlTag        xxx links to Function
    javaScriptFunction                         { Function }, -- javaScriptFunction xxx links to Function
    javaScriptBraces                           { Function }, -- javaScriptBraces xxx links to Function
    cssClassNameDot                            { Function }, -- cssClassNameDot xxx links to Function
    cssClassName                               { Function }, -- cssClassName   xxx links to Function
    cssIdentifier                              { Function }, -- cssIdentifier  xxx links to Function
    cssFunctionName                            { Function }, -- cssFunctionName xxx links to Function
    cssFunctionComma                           { Function }, -- cssFunctionComma xxx links to Function
    cssBraces                                  { Function }, -- cssBraces      xxx links to Function
    helpFunction                               { Function }, -- helpFunction   xxx links to Function
    Statement                                  { gui="bold", fg="#ff66b0", }, -- Statement      xxx cterm=bold gui=bold guifg=#ff66b0
    Conditional                                { Statement }, -- Conditional    xxx links to Statement
    Repeat                                     { Statement }, -- Repeat         xxx links to Statement
    Label                                      { Statement }, -- Label          xxx links to Statement
    Operator                                   { Statement }, -- Operator       xxx links to Statement
    Keyword                                    { Statement }, -- Keyword        xxx links to Statement
    Exception                                  { Statement }, -- Exception      xxx links to Statement
    xmlEntity                                  { Statement }, -- xmlEntity      xxx links to Statement
    xmlCdataCdata                              { Statement }, -- xmlCdataCdata  xxx links to Statement
    xmlDocTypeKeyword                          { Statement }, -- xmlDocTypeKeyword xxx links to Statement
    dtdTagName                                 { Statement }, -- dtdTagName     xxx links to Statement
    dtdEntity                                  { Statement }, -- dtdEntity      xxx links to Statement
    javaScriptStatement                        { Statement }, -- javaScriptStatement xxx links to Statement
    vbStatement                                { Statement }, -- vbStatement    xxx links to Statement
    vbKeyword                                  { Statement }, -- vbKeyword      xxx links to Statement
    cssTagName                                 { Statement }, -- cssTagName     xxx links to Statement
    cssAtRuleLogical                           { Statement }, -- cssAtRuleLogical xxx links to Statement
    htmlStatement                              { Statement }, -- htmlStatement  xxx links to Statement
    helpHeadline                               { Statement }, -- helpHeadline   xxx links to Statement
    helpStatement                              { Statement }, -- helpStatement  xxx links to Statement
    Include                                    { fg="#ff66b0", }, -- Include        xxx guifg=#ff66b0
    sym"@include"                              { Include }, -- @include       xxx links to Include
    cssAtRule                                  { Include }, -- cssAtRule      xxx links to Include
    helpInclude                                { Include }, -- helpInclude    xxx links to Include
    PreProc                                    { gui="bold", fg="#beadfa", }, -- PreProc        xxx cterm=bold gui=bold guifg=#beadfa
    PreCondit                                  { PreProc }, -- PreCondit      xxx links to PreProc
    sym"@preproc"                              { PreProc }, -- @preproc       xxx links to PreProc
    htmlPreStmt                                { PreProc }, -- htmlPreStmt    xxx links to PreProc
    htmlPreProc                                { PreProc }, -- htmlPreProc    xxx links to PreProc
    htmlPreProcAttrName                        { PreProc }, -- htmlPreProcAttrName xxx links to PreProc
    htmlHead                                   { PreProc }, -- htmlHead       xxx links to PreProc
    vbMethods                                  { PreProc }, -- vbMethods      xxx links to PreProc
    vbPreProc                                  { PreProc }, -- vbPreProc      xxx links to PreProc
    cssPseudoClassId                           { PreProc }, -- cssPseudoClassId xxx links to PreProc
    cssAtKeyword                               { PreProc }, -- cssAtKeyword   xxx links to PreProc
    cssPagePseudo                              { PreProc }, -- cssPagePseudo  xxx links to PreProc
    markdownRule                               { PreProc }, -- markdownRule   xxx links to PreProc
    yamlDocumentStart                          { PreProc }, -- yamlDocumentStart xxx links to PreProc
    yamlDocumentEnd                            { PreProc }, -- yamlDocumentEnd xxx links to PreProc
    helpSectionDelim                           { PreProc }, -- helpSectionDelim xxx links to PreProc
    helpHeader                                 { PreProc }, -- helpHeader     xxx links to PreProc
    helpPreProc                                { PreProc }, -- helpPreProc    xxx links to PreProc
    Define                                     { fg="#ff66b0", }, -- Define         xxx guifg=#ff66b0
    sym"@constant.macro"                       { Define }, -- @constant.macro xxx links to Define
    sym"@define"                               { Define }, -- @define        xxx links to Define
    helpDefine                                 { Define }, -- helpDefine     xxx links to Define
    Macro                                      { fg="#ff66b0", }, -- Macro          xxx guifg=#ff66b0
    sym"@macro"                                { Macro }, -- @macro         xxx links to Macro
    sym"@function.macro"                       { Macro }, -- @function.macro xxx links to Macro
    sym"@lsp.type.macro"                       { Macro }, -- @lsp.type.macro xxx links to Macro
    helpMacro                                  { Macro }, -- helpMacro      xxx links to Macro
    StorageClass                               { fg="#3dcfff", }, -- StorageClass   xxx guifg=#3dcfff
    sym"@storageclass"                         { StorageClass }, -- @storageclass  xxx links to StorageClass
    cssProp                                    { StorageClass }, -- cssProp        xxx links to StorageClass
    helpStorageClass                           { StorageClass }, -- helpStorageClass xxx links to StorageClass
    Type                                       { fg="#3dcfff", }, -- Type           xxx guifg=#3dcfff
    sym"@type"                                 { Type }, -- @type          xxx links to Type
    sym"@lsp.type.type"                        { Type }, -- @lsp.type.type xxx links to Type
    NvimNumberPrefix                           { Type }, -- NvimNumberPrefix xxx links to Type
    NvimOptionSigil                            { Type }, -- NvimOptionSigil xxx links to Type
    xmlAttrib                                  { Type }, -- xmlAttrib      xxx links to Type
    xmlProcessing                              { Type }, -- xmlProcessing  xxx links to Type
    xmlEntityPunct                             { Type }, -- xmlEntityPunct xxx links to Type
    xmlCdataStart                              { Type }, -- xmlCdataStart  xxx links to Type
    xmlCdataEnd                                { Type }, -- xmlCdataEnd    xxx links to Type
    dtdType                                    { Type }, -- dtdType        xxx links to Type
    htmlArg                                    { Type }, -- htmlArg        xxx links to Type
    javaScriptType                             { Type }, -- javaScriptType xxx links to Type
    vbTypes                                    { Type }, -- vbTypes        xxx links to Type
    vbTypeSpecifier                            { Type }, -- vbTypeSpecifier xxx links to Type
    markdownId                                 { Type }, -- markdownId     xxx links to Type
    yamlNodeTag                                { Type }, -- yamlNodeTag    xxx links to Type
    yamlAnchor                                 { Type }, -- yamlAnchor     xxx links to Type
    yamlAlias                                  { Type }, -- yamlAlias      xxx links to Type
    helpOption                                 { Type }, -- helpOption     xxx links to Type
    helpType                                   { Type }, -- helpType       xxx links to Type
    Structure                                  { fg="#3dcfff", }, -- Structure      xxx guifg=#3dcfff
    sym"@lsp.type.class"                       { Structure }, -- @lsp.type.class xxx links to Structure
    sym"@lsp.type.enum"                        { Structure }, -- @lsp.type.enum xxx links to Structure
    sym"@lsp.type.interface"                   { Structure }, -- @lsp.type.interface xxx links to Structure
    sym"@lsp.type.namespace"                   { Structure }, -- @lsp.type.namespace xxx links to Structure
    sym"@lsp.type.struct"                      { Structure }, -- @lsp.type.struct xxx links to Structure
    helpStructure                              { Structure }, -- helpStructure  xxx links to Structure
    Typedef                                    { fg="#3dcfff", }, -- Typedef        xxx guifg=#3dcfff
    sym"@type.definition"                      { Typedef }, -- @type.definition xxx links to Typedef
    sym"@lsp.type.typeParameter"               { Typedef }, -- @lsp.type.typeParameter xxx links to Typedef
    markdownIdDeclaration                      { Typedef }, -- markdownIdDeclaration xxx links to Typedef
    markdownFootnote                           { Typedef }, -- markdownFootnote xxx links to Typedef
    markdownFootnoteDefinition                 { Typedef }, -- markdownFootnoteDefinition xxx links to Typedef
    helpTypedef                                { Typedef }, -- helpTypedef    xxx links to Typedef
    Tag                                        { gui="bold", fg="#beadfa", }, -- Tag            xxx cterm=bold gui=bold guifg=#beadfa
    sym"@tag"                                  { Tag }, -- @tag           xxx links to Tag
    xmlNamespace                               { Tag }, -- xmlNamespace   xxx links to Tag
    helpTag                                    { Tag }, -- helpTag        xxx links to Tag
    Special                                    { fg="#feffad", }, -- Special        xxx guifg=#feffad
    Delimiter                                  { Special }, -- Delimiter      xxx links to Special
    SpecialComment                             { Special }, -- SpecialComment xxx links to Special
    Debug                                      { Special }, -- Debug          xxx links to Special
    sym"@constant.builtin"                     { Special }, -- @constant.builtin xxx links to Special
    sym"@function.builtin"                     { Special }, -- @function.builtin xxx links to Special
    sym"@constructor"                          { Special }, -- @constructor   xxx links to Special
    htmlSpecialChar                            { Special }, -- htmlSpecialChar xxx links to Special
    htmlCssDefinition                          { Special }, -- htmlCssDefinition xxx links to Special
    javaScript                                 { Special }, -- javaScript     xxx links to Special
    javaScriptSpecial                          { Special }, -- javaScriptSpecial xxx links to Special
    javaScriptEmbed                            { Special }, -- javaScriptEmbed xxx links to Special
    vbEvents                                   { Special }, -- vbEvents       xxx links to Special
    cssSelectorOp                              { Special }, -- cssSelectorOp  xxx links to Special
    cssSelectorOp2                             { Special }, -- cssSelectorOp2 xxx links to Special
    cssUnicodeEscape                           { Special }, -- cssUnicodeEscape xxx links to Special
    cssImportant                               { Special }, -- cssImportant   xxx links to Special
    cssCustomProp                              { Special }, -- cssCustomProp  xxx links to Special
    cssAttrComma                               { Special }, -- cssAttrComma   xxx links to Special
    cssMediaType                               { Special }, -- cssMediaType   xxx links to Special
    cssFontDescriptor                          { Special }, -- cssFontDescriptor xxx links to Special
    markdownEscape                             { Special }, -- markdownEscape xxx links to Special
    yamlKeyValueDelimiter                      { Special }, -- yamlKeyValueDelimiter xxx links to Special
    yamlFlowMappingMerge                       { Special }, -- yamlFlowMappingMerge xxx links to Special
    yamlMappingKeyStart                        { Special }, -- yamlMappingKeyStart xxx links to Special
    yamlFlowIndicator                          { Special }, -- yamlFlowIndicator xxx links to Special
    yamlBlockMappingMerge                      { Special }, -- yamlBlockMappingMerge xxx links to Special
    helpSpecial                                { Special }, -- helpSpecial    xxx links to Special
    SpecialChar                                { fg="#feffad", }, -- SpecialChar    xxx guifg=#feffad
    sym"@string.escape"                        { SpecialChar }, -- @string.escape xxx links to SpecialChar
    sym"@string.special"                       { SpecialChar }, -- @string.special xxx links to SpecialChar
    sym"@character.special"                    { SpecialChar }, -- @character.special xxx links to SpecialChar
    NvimRegister                               { SpecialChar }, -- NvimRegister   xxx links to SpecialChar
    NvimStringSpecial                          { SpecialChar }, -- NvimStringSpecial xxx links to SpecialChar
    NeoTreeBufferNumber                        { SpecialChar }, -- NeoTreeBufferNumber xxx links to SpecialChar
    NeoTreeFilterTerm                          { SpecialChar }, -- NeoTreeFilterTerm xxx links to SpecialChar
    yamlEscape                                 { SpecialChar }, -- yamlEscape     xxx links to SpecialChar
    yamlSingleEscape                           { SpecialChar }, -- yamlSingleEscape xxx links to SpecialChar
    helpSpecialChar                            { SpecialChar }, -- helpSpecialChar xxx links to SpecialChar
    DiagnosticError                            { fg="red", }, -- DiagnosticError xxx ctermfg=1 guifg=Red
    DiagnosticVirtualTextError                 { DiagnosticError }, -- DiagnosticVirtualTextError xxx links to DiagnosticError
    DiagnosticFloatingError                    { DiagnosticError }, -- DiagnosticFloatingError xxx links to DiagnosticError
    DiagnosticSignError                        { DiagnosticError }, -- DiagnosticSignError xxx links to DiagnosticError
    DiagnosticWarn                             { fg="orange", }, -- DiagnosticWarn xxx ctermfg=3 guifg=Orange
    DiagnosticVirtualTextWarn                  { DiagnosticWarn }, -- DiagnosticVirtualTextWarn xxx links to DiagnosticWarn
    DiagnosticFloatingWarn                     { DiagnosticWarn }, -- DiagnosticFloatingWarn xxx links to DiagnosticWarn
    DiagnosticSignWarn                         { DiagnosticWarn }, -- DiagnosticSignWarn xxx links to DiagnosticWarn
    DiagnosticInfo                             { fg="lightblue", }, -- DiagnosticInfo xxx ctermfg=4 guifg=LightBlue
    DiagnosticVirtualTextInfo                  { DiagnosticInfo }, -- DiagnosticVirtualTextInfo xxx links to DiagnosticInfo
    DiagnosticFloatingInfo                     { DiagnosticInfo }, -- DiagnosticFloatingInfo xxx links to DiagnosticInfo
    DiagnosticSignInfo                         { DiagnosticInfo }, -- DiagnosticSignInfo xxx links to DiagnosticInfo
    DiagnosticOk                               { fg="lightgreen", }, -- DiagnosticOk   xxx ctermfg=10 guifg=LightGreen
    DiagnosticVirtualTextOk                    { DiagnosticOk }, -- DiagnosticVirtualTextOk xxx links to DiagnosticOk
    DiagnosticFloatingOk                       { DiagnosticOk }, -- DiagnosticFloatingOk xxx links to DiagnosticOk
    DiagnosticSignOk                           { DiagnosticOk }, -- DiagnosticSignOk xxx links to DiagnosticOk
    DiagnosticUnderlineError                   { sp="red", gui="underline", }, -- DiagnosticUnderlineError xxx cterm=underline gui=underline guisp=Red
    DiagnosticUnderlineWarn                    { sp="orange", gui="underline", }, -- DiagnosticUnderlineWarn xxx cterm=underline gui=underline guisp=Orange
    DiagnosticUnderlineInfo                    { sp="lightblue", gui="underline", }, -- DiagnosticUnderlineInfo xxx cterm=underline gui=underline guisp=LightBlue
    DiagnosticUnderlineHint                    { sp="lightgrey", gui="underline", }, -- DiagnosticUnderlineHint xxx cterm=underline gui=underline guisp=LightGrey
    DiagnosticUnderlineOk                      { sp="lightgreen", gui="underline", }, -- DiagnosticUnderlineOk xxx cterm=underline gui=underline guisp=LightGreen
    DiagnosticVirtualTextHint                  { fg="#c7f1ff", }, -- DiagnosticVirtualTextHint xxx guifg=#c7f1ff
    DiagnosticHint                             { DiagnosticVirtualTextHint }, -- DiagnosticHint xxx links to DiagnosticVirtualTextHint
    DiagnosticSignHint                         { DiagnosticVirtualTextHint }, -- DiagnosticSignHint xxx links to DiagnosticVirtualTextHint
    DiagnosticDeprecated                       { sp="red", gui="strikethrough", }, -- DiagnosticDeprecated xxx cterm=strikethrough gui=strikethrough guisp=Red
    Comment                                    { gui="italic", fg="#387a6b", }, -- Comment        xxx cterm=italic gui=italic guifg=#387a6b
    DiagnosticUnnecessary                      { Comment }, -- DiagnosticUnnecessary xxx links to Comment
    sym"@text.literal"                         { Comment }, -- @text.literal  xxx links to Comment
    sym"@comment"                              { Comment }, -- @comment       xxx links to Comment
    sym"@lsp.type.comment"                     { Comment }, -- @lsp.type.comment xxx links to Comment
    xmlAttribPunct                             { Comment }, -- xmlAttribPunct xxx links to Comment
    xmlComment                                 { Comment }, -- xmlComment     xxx links to Comment
    xmlCommentPart                             { Comment }, -- xmlCommentPart xxx links to Comment
    xmlProcessingDelim                         { Comment }, -- xmlProcessingDelim xxx links to Comment
    dtdComment                                 { Comment }, -- dtdComment     xxx links to Comment
    htmlComment                                { Comment }, -- htmlComment    xxx links to Comment
    javaScriptLineComment                      { Comment }, -- javaScriptLineComment xxx links to Comment
    javaScriptComment                          { Comment }, -- javaScriptComment xxx links to Comment
    htmlCssStyleComment                        { Comment }, -- htmlCssStyleComment xxx links to Comment
    vbComment                                  { Comment }, -- vbComment      xxx links to Comment
    vbLineLabel                                { Comment }, -- vbLineLabel    xxx links to Comment
    vbLineNumber                               { Comment }, -- vbLineNumber   xxx links to Comment
    cssComment                                 { Comment }, -- cssComment     xxx links to Comment
    cssVendor                                  { Comment }, -- cssVendor      xxx links to Comment
    cssHacks                                   { Comment }, -- cssHacks       xxx links to Comment
    markdownBlockquote                         { Comment }, -- markdownBlockquote xxx links to Comment
    yamlComment                                { Comment }, -- yamlComment    xxx links to Comment
    helpExample                                { Comment }, -- helpExample    xxx links to Comment
    helpCommand                                { Comment }, -- helpCommand    xxx links to Comment
    helpComment                                { Comment }, -- helpComment    xxx links to Comment
    Underlined                                 { gui="underline", fg="#80a0ff", }, -- Underlined     xxx cterm=underline ctermfg=81 gui=underline guifg=#80a0ff
    sym"@text.uri"                             { Underlined }, -- @text.uri      xxx links to Underlined
    sym"@text.underline"                       { Underlined }, -- @text.underline xxx links to Underlined
    htmlLink                                   { Underlined }, -- htmlLink       xxx links to Underlined
    helpUnderlined                             { Underlined }, -- helpUnderlined xxx links to Underlined
    MatchParen                                 { bg="#adadad", gui="underline", }, -- MatchParen     xxx cterm=underline gui=underline guibg=#adadad
    Ignore                                     { fg="bg", }, -- Ignore         xxx ctermfg=0 guifg=bg
    helpIgnore                                 { Ignore }, -- helpIgnore     xxx links to Ignore
    helpBar                                    { Ignore }, -- helpBar        xxx links to Ignore
    helpStar                                   { Ignore }, -- helpStar       xxx links to Ignore
    helpBacktick                               { Ignore }, -- helpBacktick   xxx links to Ignore
    NvimInternalError                          { bg="red", fg="red", }, -- NvimInternalError xxx ctermfg=9 ctermbg=9 guifg=Red guibg=Red
    NvimFigureBrace                            { NvimInternalError }, -- NvimFigureBrace xxx links to NvimInternalError
    NvimSingleQuotedUnknownEscape              { NvimInternalError }, -- NvimSingleQuotedUnknownEscape xxx links to NvimInternalError
    NvimInvalidSingleQuotedUnknownEscape       { NvimInternalError }, -- NvimInvalidSingleQuotedUnknownEscape xxx links to NvimInternalError
    Underline                                  { gui="bold,underline", fg="#beadfa", }, -- Underline      xxx cterm=bold,underline gui=bold,underline guifg=#beadfa
    Cursor2                                    { bg="white", fg="white", }, -- Cursor2        xxx guifg=White guibg=White
    lualine_a_insert                           { bg="#80a0ff", fg="#080808", }, -- lualine_a_insert xxx guifg=#080808 guibg=#80a0ff
    lualine_b_normal                           { bg="#303030", fg="#c6c6c6", }, -- lualine_b_normal xxx guifg=#c6c6c6 guibg=#303030
    lualine_c_normal                           { bg="#080808", fg="#080808", }, -- lualine_c_normal xxx guifg=#080808 guibg=#080808
    lualine_a_normal                           { bg="#d183e8", fg="#080808", }, -- lualine_a_normal xxx guifg=#080808 guibg=#d183e8
    lualine_a_visual                           { bg="#79dac8", fg="#080808", }, -- lualine_a_visual xxx guifg=#080808 guibg=#79dac8
    lualine_a_replace                          { bg="#ff5189", fg="#080808", }, -- lualine_a_replace xxx guifg=#080808 guibg=#ff5189
    lualine_b_inactive                         { bg="#080808", fg="#c6c6c6", }, -- lualine_b_inactive xxx guifg=#c6c6c6 guibg=#080808
    lualine_c_inactive                         { bg="#080808", fg="#080808", }, -- lualine_c_inactive xxx guifg=#080808 guibg=#080808
    lualine_a_inactive                         { bg="#080808", fg="#c6c6c6", }, -- lualine_a_inactive xxx guifg=#c6c6c6 guibg=#080808
    TelescopePreviewSize                       { }, -- TelescopePreviewSize xxx cterm= gui=
    TelescopePreviewUser                       { }, -- TelescopePreviewUser xxx cterm= gui=
    TelescopePreviewGroup                      { }, -- TelescopePreviewGroup xxx cterm= gui=
    TelescopePreviewDate                       { }, -- TelescopePreviewDate xxx cterm= gui=
    TelescopePreviewMessage                    { }, -- TelescopePreviewMessage xxx cterm= gui=
    TelescopePreviewNormal                     { }, -- TelescopePreviewNormal xxx cterm= gui=
    TelescopePreviewMessageFillchar            { }, -- TelescopePreviewMessageFillchar xxx cterm= gui=
    TelescopeResultsClass                      { }, -- TelescopeResultsClass xxx cterm= gui=
    TelescopeResultsConstant                   { }, -- TelescopeResultsConstant xxx cterm= gui=
    TelescopeResultsField                      { }, -- TelescopeResultsField xxx cterm= gui=
    TelescopeResultsFunction                   { }, -- TelescopeResultsFunction xxx cterm= gui=
    TelescopeResultsMethod                     { }, -- TelescopeResultsMethod xxx cterm= gui=
    TelescopeResultsOperator                   { }, -- TelescopeResultsOperator xxx cterm= gui=
    TelescopeResultsStruct                     { }, -- TelescopeResultsStruct xxx cterm= gui=
    TelescopeResultsVariable                   { }, -- TelescopeResultsVariable xxx cterm= gui=
    TelescopeResultsLineNr                     { }, -- TelescopeResultsLineNr xxx cterm= gui=
    TelescopeResultsIdentifier                 { }, -- TelescopeResultsIdentifier xxx cterm= gui=
    TelescopeResultsNumber                     { }, -- TelescopeResultsNumber xxx cterm= gui=
    TelescopeResultsComment                    { }, -- TelescopeResultsComment xxx cterm= gui=
    TelescopeResultsSpecialComment             { }, -- TelescopeResultsSpecialComment xxx cterm= gui=
    TelescopeResultsDiffChange                 { }, -- TelescopeResultsDiffChange xxx cterm= gui=
    TelescopeResultsDiffAdd                    { }, -- TelescopeResultsDiffAdd xxx cterm= gui=
    TelescopeResultsDiffDelete                 { }, -- TelescopeResultsDiffDelete xxx cterm= gui=
    TelescopeResultsDiffUntracked              { }, -- TelescopeResultsDiffUntracked xxx cterm= gui=
    TelescopeSelection                         { }, -- TelescopeSelection xxx cterm= gui=
    TelescopeSelectionCaret                    { }, -- TelescopeSelectionCaret xxx cterm= gui=
    TelescopeMultiSelection                    { }, -- TelescopeMultiSelection xxx cterm= gui=
    TelescopeMultiIcon                         { }, -- TelescopeMultiIcon xxx cterm= gui=
    TelescopeNormal                            { }, -- TelescopeNormal xxx cterm= gui=
    TelescopePromptNormal                      { }, -- TelescopePromptNormal xxx cterm= gui=
    TelescopeResultsNormal                     { }, -- TelescopeResultsNormal xxx cterm= gui=
    TelescopeBorder                            { }, -- TelescopeBorder xxx cterm= gui=
    TelescopePromptBorder                      { }, -- TelescopePromptBorder xxx cterm= gui=
    TelescopeResultsBorder                     { }, -- TelescopeResultsBorder xxx cterm= gui=
    TelescopePreviewBorder                     { }, -- TelescopePreviewBorder xxx cterm= gui=
    TelescopeTitle                             { }, -- TelescopeTitle xxx cterm= gui=
    TelescopePromptTitle                       { }, -- TelescopePromptTitle xxx cterm= gui=
    TelescopeResultsTitle                      { }, -- TelescopeResultsTitle xxx cterm= gui=
    TelescopePreviewTitle                      { }, -- TelescopePreviewTitle xxx cterm= gui=
    TelescopePromptCounter                     { }, -- TelescopePromptCounter xxx cterm= gui=
    TelescopeMatching                          { }, -- TelescopeMatching xxx cterm= gui=
    TelescopePromptPrefix                      { }, -- TelescopePromptPrefix xxx cterm= gui=
    TelescopePreviewLine                       { }, -- TelescopePreviewLine xxx cterm= gui=
    TelescopePreviewMatch                      { }, -- TelescopePreviewMatch xxx cterm= gui=
    TelescopePreviewPipe                       { }, -- TelescopePreviewPipe xxx cterm= gui=
    TelescopePreviewCharDev                    { }, -- TelescopePreviewCharDev xxx cterm= gui=
    TelescopePreviewDirectory                  { }, -- TelescopePreviewDirectory xxx cterm= gui=
    TelescopePreviewBlock                      { }, -- TelescopePreviewBlock xxx cterm= gui=
    TelescopePreviewLink                       { }, -- TelescopePreviewLink xxx cterm= gui=
    TelescopePreviewSocket                     { }, -- TelescopePreviewSocket xxx cterm= gui=
    TelescopePreviewRead                       { }, -- TelescopePreviewRead xxx cterm= gui=
    TelescopePreviewWrite                      { }, -- TelescopePreviewWrite xxx cterm= gui=
    TelescopePreviewExecute                    { }, -- TelescopePreviewExecute xxx cterm= gui=
    TelescopePreviewHyphen                     { }, -- TelescopePreviewHyphen xxx cterm= gui=
    TelescopePreviewSticky                     { }, -- TelescopePreviewSticky xxx cterm= gui=
    LspInfoList                                { }, -- LspInfoList    xxx cterm= gui=
    LspInfoTip                                 { }, -- LspInfoTip     xxx cterm= gui=
    LspInfoTitle                               { }, -- LspInfoTitle   xxx cterm= gui=
    LspInfoFiletype                            { }, -- LspInfoFiletype xxx cterm= gui=
    LspInfoBorder                              { }, -- LspInfoBorder  xxx cterm= gui=
    CmpItemAbbr                                { }, -- CmpItemAbbr    xxx cterm= gui=
    CmpItemAbbrDeprecated                      { }, -- CmpItemAbbrDeprecated xxx cterm= gui=
    CmpItemAbbrDeprecatedDefault               { fg="#387a6b", }, -- CmpItemAbbrDeprecatedDefault xxx guifg=#387a6b
    CmpItemAbbrMatch                           { }, -- CmpItemAbbrMatch xxx cterm= gui=
    CmpItemAbbrMatchFuzzy                      { }, -- CmpItemAbbrMatchFuzzy xxx cterm= gui=
    CmpItemKind                                { }, -- CmpItemKind    xxx cterm= gui=
    CmpItemKindTextDefault                     { CmpItemKind }, -- CmpItemKindTextDefault xxx links to CmpItemKind
    CmpItemKindMethodDefault                   { CmpItemKind }, -- CmpItemKindMethodDefault xxx links to CmpItemKind
    CmpItemKindConstructorDefault              { CmpItemKind }, -- CmpItemKindConstructorDefault xxx links to CmpItemKind
    CmpItemKindFieldDefault                    { CmpItemKind }, -- CmpItemKindFieldDefault xxx links to CmpItemKind
    CmpItemKindVariableDefault                 { CmpItemKind }, -- CmpItemKindVariableDefault xxx links to CmpItemKind
    CmpItemKindClassDefault                    { CmpItemKind }, -- CmpItemKindClassDefault xxx links to CmpItemKind
    CmpItemKindInterfaceDefault                { CmpItemKind }, -- CmpItemKindInterfaceDefault xxx links to CmpItemKind
    CmpItemKindModuleDefault                   { CmpItemKind }, -- CmpItemKindModuleDefault xxx links to CmpItemKind
    CmpItemKindPropertyDefault                 { CmpItemKind }, -- CmpItemKindPropertyDefault xxx links to CmpItemKind
    CmpItemKindUnitDefault                     { CmpItemKind }, -- CmpItemKindUnitDefault xxx links to CmpItemKind
    CmpItemKindValueDefault                    { CmpItemKind }, -- CmpItemKindValueDefault xxx links to CmpItemKind
    CmpItemKindEnumDefault                     { CmpItemKind }, -- CmpItemKindEnumDefault xxx links to CmpItemKind
    CmpItemKindKeywordDefault                  { CmpItemKind }, -- CmpItemKindKeywordDefault xxx links to CmpItemKind
    CmpItemKindFunctionDefault                 { CmpItemKind }, -- CmpItemKindFunctionDefault xxx links to CmpItemKind
    CmpItemKindEventDefault                    { CmpItemKind }, -- CmpItemKindEventDefault xxx links to CmpItemKind
    CmpItemKindConstantDefault                 { CmpItemKind }, -- CmpItemKindConstantDefault xxx links to CmpItemKind
    CmpItemKindTypeParameterDefault            { CmpItemKind }, -- CmpItemKindTypeParameterDefault xxx links to CmpItemKind
    CmpItemKindOperatorDefault                 { CmpItemKind }, -- CmpItemKindOperatorDefault xxx links to CmpItemKind
    CmpItemKindSnippetDefault                  { CmpItemKind }, -- CmpItemKindSnippetDefault xxx links to CmpItemKind
    CmpItemKindColorDefault                    { CmpItemKind }, -- CmpItemKindColorDefault xxx links to CmpItemKind
    CmpItemKindFileDefault                     { CmpItemKind }, -- CmpItemKindFileDefault xxx links to CmpItemKind
    CmpItemKindReferenceDefault                { CmpItemKind }, -- CmpItemKindReferenceDefault xxx links to CmpItemKind
    CmpItemKindFolderDefault                   { CmpItemKind }, -- CmpItemKindFolderDefault xxx links to CmpItemKind
    CmpItemKindEnumMemberDefault               { CmpItemKind }, -- CmpItemKindEnumMemberDefault xxx links to CmpItemKind
    CmpItemKindStructDefault                   { CmpItemKind }, -- CmpItemKindStructDefault xxx links to CmpItemKind
    CmpItemKindDefault                         { fg="#feffad", }, -- CmpItemKindDefault xxx guifg=#feffad
    CmpItemMenu                                { }, -- CmpItemMenu    xxx cterm= gui=
    CmpItemKindText                            { }, -- CmpItemKindText xxx cterm= gui=
    CmpItemKindMethod                          { }, -- CmpItemKindMethod xxx cterm= gui=
    CmpItemKindConstructor                     { }, -- CmpItemKindConstructor xxx cterm= gui=
    CmpItemKindField                           { }, -- CmpItemKindField xxx cterm= gui=
    CmpItemKindVariable                        { }, -- CmpItemKindVariable xxx cterm= gui=
    CmpItemKindClass                           { }, -- CmpItemKindClass xxx cterm= gui=
    CmpItemKindInterface                       { }, -- CmpItemKindInterface xxx cterm= gui=
    CmpItemKindModule                          { }, -- CmpItemKindModule xxx cterm= gui=
    CmpItemKindProperty                        { }, -- CmpItemKindProperty xxx cterm= gui=
    CmpItemKindUnit                            { }, -- CmpItemKindUnit xxx cterm= gui=
    CmpItemKindValue                           { }, -- CmpItemKindValue xxx cterm= gui=
    CmpItemKindEnum                            { }, -- CmpItemKindEnum xxx cterm= gui=
    CmpItemKindKeyword                         { }, -- CmpItemKindKeyword xxx cterm= gui=
    CmpItemKindFunction                        { }, -- CmpItemKindFunction xxx cterm= gui=
    CmpItemKindEvent                           { }, -- CmpItemKindEvent xxx cterm= gui=
    CmpItemKindConstant                        { }, -- CmpItemKindConstant xxx cterm= gui=
    CmpItemKindTypeParameter                   { }, -- CmpItemKindTypeParameter xxx cterm= gui=
    CmpItemKindOperator                        { }, -- CmpItemKindOperator xxx cterm= gui=
    CmpItemKindSnippet                         { }, -- CmpItemKindSnippet xxx cterm= gui=
    CmpItemKindColor                           { }, -- CmpItemKindColor xxx cterm= gui=
    CmpItemKindFile                            { }, -- CmpItemKindFile xxx cterm= gui=
    CmpItemKindReference                       { }, -- CmpItemKindReference xxx cterm= gui=
    CmpItemKindFolder                          { }, -- CmpItemKindFolder xxx cterm= gui=
    CmpItemKindEnumMember                      { }, -- CmpItemKindEnumMember xxx cterm= gui=
    CmpItemKindStruct                          { }, -- CmpItemKindStruct xxx cterm= gui=
    TSPlaygroundLang                           { }, -- TSPlaygroundLang xxx cterm= gui=
    TSPlaygroundFocus                          { }, -- TSPlaygroundFocus xxx cterm= gui=
    TSQueryLinterError                         { }, -- TSQueryLinterError xxx cterm= gui=
    ExtraWhitespace                            { bg="#ff0000", }, -- ExtraWhitespace xxx ctermbg=9 guibg=#ff0000
    NeoTreeFloatTitle                          { bg="#272b34", fg="#dedede", }, -- NeoTreeFloatTitle xxx guifg=#dedede guibg=#272b34
    NeoTreeTitleBar                            { bg="#dedede", fg="#272b34", }, -- NeoTreeTitleBar xxx guifg=#272b34 guibg=#dedede
    NeoTreeMessage                             { gui="italic", fg="#5d6067", }, -- NeoTreeMessage xxx gui=italic guifg=#5d6067
    NeoTreeFadeText1                           { fg="#626262", }, -- NeoTreeFadeText1 xxx guifg=#626262
    NeoTreeFadeText2                           { fg="#444444", }, -- NeoTreeFadeText2 xxx guifg=#444444
    NeoTreeDotfile                             { fg="#626262", }, -- NeoTreeDotfile xxx guifg=#626262
    NeoTreeHiddenByName                        { NeoTreeDotfile }, -- NeoTreeHiddenByName xxx links to NeoTreeDotfile
    NeoTreeWindowsHidden                       { NeoTreeDotfile }, -- NeoTreeWindowsHidden xxx links to NeoTreeDotfile
    NeoTreeGitIgnored                          { NeoTreeDotfile }, -- NeoTreeGitIgnored xxx links to NeoTreeDotfile
    NeoTreeDimText                             { fg="#5d6067", }, -- NeoTreeDimText xxx guifg=#5d6067
    NeoTreeIndentMarker                        { NeoTreeDimText }, -- NeoTreeIndentMarker xxx links to NeoTreeDimText
    NeoTreeExpander                            { NeoTreeDimText }, -- NeoTreeExpander xxx links to NeoTreeDimText
    NeoTreeFileNameOpened                      { gui="bold", }, -- NeoTreeFileNameOpened xxx gui=bold
    NeoTreeRootName                            { gui="bold,italic", }, -- NeoTreeRootName xxx gui=bold,italic
    NeoTreeModified                            { fg="#d7d787", }, -- NeoTreeModified xxx guifg=#d7d787
    NeoTreeGitAdded                            { fg="#5faf5f", }, -- NeoTreeGitAdded xxx guifg=#5faf5f
    NeoTreeGitStaged                           { NeoTreeGitAdded }, -- NeoTreeGitStaged xxx links to NeoTreeGitAdded
    NeoTreeGitDeleted                          { fg="#ff5900", }, -- NeoTreeGitDeleted xxx guifg=#ff5900
    NeoTreeGitModified                         { fg="#d7af5f", }, -- NeoTreeGitModified xxx guifg=#d7af5f
    NeoTreeGitRenamed                          { NeoTreeGitModified }, -- NeoTreeGitRenamed xxx links to NeoTreeGitModified
    NeoTreeGitConflict                         { gui="bold,italic", fg="#ff8700", }, -- NeoTreeGitConflict xxx gui=bold,italic guifg=#ff8700
    NeoTreeGitUnstaged                         { NeoTreeGitConflict }, -- NeoTreeGitUnstaged xxx links to NeoTreeGitConflict
    NeoTreeGitUntracked                        { gui="italic", fg="#ff8700", }, -- NeoTreeGitUntracked xxx gui=italic guifg=#ff8700
    NeoTreeTabActive                           { gui="bold", }, -- NeoTreeTabActive xxx gui=bold
    NeoTreeTabInactive                         { bg="#141414", fg="#777777", }, -- NeoTreeTabInactive xxx guifg=#777777 guibg=#141414
    NeoTreeTabSeparatorActive                  { fg="#0a0a0a", }, -- NeoTreeTabSeparatorActive xxx guifg=#0a0a0a
    NeoTreeTabSeparatorInactive                { bg="#141414", fg="#101010", }, -- NeoTreeTabSeparatorInactive xxx guifg=#101010 guibg=#141414
    NeoTreeFileStats                           { fg="#707278", }, -- NeoTreeFileStats xxx guifg=#707278
    NeoTreeFileStatsHeader                     { gui="bold,italic", fg="#828489", }, -- NeoTreeFileStatsHeader xxx gui=bold,italic guifg=#828489
    DevIconKsh                                 { fg="#4d5a5e", }, -- DevIconKsh     xxx ctermfg=240 guifg=#4d5a5e
    DevIconSig                                 { fg="#e37933", }, -- DevIconSig     xxx ctermfg=166 guifg=#e37933
    DevIconExs                                 { fg="#a074c4", }, -- DevIconExs     xxx ctermfg=140 guifg=#a074c4
    DevIconLeex                                { fg="#a074c4", }, -- DevIconLeex    xxx ctermfg=140 guifg=#a074c4
    DevIconTcl                                 { fg="#1e5cb3", }, -- DevIconTcl     xxx ctermfg=25 guifg=#1e5cb3
    DevIconCPlusPlus                           { fg="#f34b7d", }, -- DevIconCPlusPlus xxx ctermfg=204 guifg=#f34b7d
    DevIconCss                                 { fg="#42a5f5", }, -- DevIconCss     xxx ctermfg=75 guifg=#42a5f5
    DevIconLhs                                 { fg="#a074c4", }, -- DevIconLhs     xxx ctermfg=140 guifg=#a074c4
    DevIconTerraform                           { fg="#5f43e9", }, -- DevIconTerraform xxx ctermfg=93 guifg=#5f43e9
    DevIconJson5                               { fg="#cbcb41", }, -- DevIconJson5   xxx ctermfg=185 guifg=#cbcb41
    DevIconD                                   { fg="#427819", }, -- DevIconD       xxx ctermfg=28 guifg=#427819
    DevIconJsonc                               { fg="#cbcb41", }, -- DevIconJsonc   xxx ctermfg=185 guifg=#cbcb41
    DevIconCobol                               { fg="#005ca5", }, -- DevIconCobol   xxx ctermfg=25 guifg=#005ca5
    DevIconDart                                { fg="#03589c", }, -- DevIconDart    xxx ctermfg=25 guifg=#03589c
    DevIconPm                                  { fg="#519aba", }, -- DevIconPm      xxx ctermfg=74 guifg=#519aba
    DevIconDump                                { fg="#dad8d8", }, -- DevIconDump    xxx ctermfg=188 guifg=#dad8d8
    DevIconDockerfile                          { fg="#458ee6", }, -- DevIconDockerfile xxx ctermfg=68 guifg=#458ee6
    DevIconTex                                 { fg="#3d6117", }, -- DevIconTex     xxx ctermfg=22 guifg=#3d6117
    DevIconZsh                                 { fg="#89e051", }, -- DevIconZsh     xxx ctermfg=113 guifg=#89e051
    DevIconLuau                                { fg="#51a0cf", }, -- DevIconLuau    xxx ctermfg=74 guifg=#51a0cf
    DevIconElm                                 { fg="#519aba", }, -- DevIconElm     xxx ctermfg=74 guifg=#519aba
    DevIconEslintrc                            { fg="#4b32c3", }, -- DevIconEslintrc xxx ctermfg=56 guifg=#4b32c3
    DevIconBabelrc                             { fg="#cbcb41", }, -- DevIconBabelrc xxx ctermfg=185 guifg=#cbcb41
    DevIconFish                                { fg="#4d5a5e", }, -- DevIconFish    xxx ctermfg=240 guifg=#4d5a5e
    DevIconNix                                 { fg="#7ebae4", }, -- DevIconNix     xxx ctermfg=110 guifg=#7ebae4
    DevIconOrgMode                             { fg="#77aa99", }, -- DevIconOrgMode xxx ctermfg=73 guifg=#77aa99
    DevIconRb                                  { fg="#701516", }, -- DevIconRb      xxx ctermfg=52 guifg=#701516
    DevIconPy                                  { fg="#ffbc03", }, -- DevIconPy      xxx ctermfg=214 guifg=#ffbc03
    DevIconGitIgnore                           { fg="#41535b", }, -- DevIconGitIgnore xxx ctermfg=239 guifg=#41535b
    DevIconGitAttributes                       { fg="#41535b", }, -- DevIconGitAttributes xxx ctermfg=239 guifg=#41535b
    DevIconGitModules                          { fg="#41535b", }, -- DevIconGitModules xxx ctermfg=239 guifg=#41535b
    DevIconGitConfig                           { fg="#41535b", }, -- DevIconGitConfig xxx ctermfg=239 guifg=#41535b
    DevIconNodeModules                         { fg="#e8274b", }, -- DevIconNodeModules xxx ctermfg=197 guifg=#e8274b
    DevIconPackageJson                         { fg="#e8274b", }, -- DevIconPackageJson xxx guifg=#e8274b
    DevIconReScript                            { fg="#cc3e44", }, -- DevIconReScript xxx ctermfg=167 guifg=#cc3e44
    DevIconPsScriptfile                        { fg="#4273ca", }, -- DevIconPsScriptfile xxx ctermfg=68 guifg=#4273ca
    DevIconZshrc                               { fg="#89e051", }, -- DevIconZshrc   xxx ctermfg=113 guifg=#89e051
    DevIconPsManifestfile                      { fg="#6975c4", }, -- DevIconPsManifestfile xxx ctermfg=68 guifg=#6975c4
    DevIconZshprofile                          { fg="#89e051", }, -- DevIconZshprofile xxx ctermfg=113 guifg=#89e051
    DevIconPrisma                              { fg="#ffffff", }, -- DevIconPrisma  xxx ctermfg=231 guifg=#ffffff
    DevIconGraphQL                             { fg="#e535ab", }, -- DevIconGraphQL xxx ctermfg=199 guifg=#e535ab
    DevIconZshenv                              { fg="#89e051", }, -- DevIconZshenv  xxx ctermfg=113 guifg=#89e051
    DevIconMixLock                             { fg="#a074c4", }, -- DevIconMixLock xxx ctermfg=140 guifg=#a074c4
    DevIconEditorConfig                        { fg="#ffffff", }, -- DevIconEditorConfig xxx ctermfg=15 guifg=#ffffff
    DevIconNPMrc                               { fg="#e8274b", }, -- DevIconNPMrc   xxx ctermfg=197 guifg=#e8274b
    DevIconHeex                                { fg="#a074c4", }, -- DevIconHeex    xxx ctermfg=140 guifg=#a074c4
    DevIconDesktopEntry                        { fg="#563d7c", }, -- DevIconDesktopEntry xxx ctermfg=54 guifg=#563d7c
    DevIconSwift                               { fg="#e37933", }, -- DevIconSwift   xxx ctermfg=166 guifg=#e37933
    DevIconSh                                  { fg="#4d5a5e", }, -- DevIconSh      xxx ctermfg=240 guifg=#4d5a5e
    DevIconCpp                                 { fg="#519aba", }, -- DevIconCpp     xxx ctermfg=74 guifg=#519aba
    DevIconHs                                  { fg="#a074c4", }, -- DevIconHs      xxx ctermfg=140 guifg=#a074c4
    DevIconJava                                { fg="#cc3e44", }, -- DevIconJava    xxx ctermfg=167 guifg=#cc3e44
    DevIconHbs                                 { fg="#f0772b", }, -- DevIconHbs     xxx ctermfg=202 guifg=#f0772b
    DevIconScala                               { fg="#cc3e44", }, -- DevIconScala   xxx ctermfg=167 guifg=#cc3e44
    DevIconHaml                                { fg="#eaeae1", }, -- DevIconHaml    xxx ctermfg=255 guifg=#eaeae1
    DevIconScss                                { fg="#f55385", }, -- DevIconScss    xxx ctermfg=204 guifg=#f55385
    DevIconPdf                                 { fg="#b30b00", }, -- DevIconPdf     xxx ctermfg=124 guifg=#b30b00
    DevIconLess                                { fg="#563d7c", }, -- DevIconLess    xxx ctermfg=54 guifg=#563d7c
    DevIconBazelWorkspace                      { fg="#89e051", }, -- DevIconBazelWorkspace xxx ctermfg=113 guifg=#89e051
    DevIconSql                                 { fg="#dad8d8", }, -- DevIconSql     xxx ctermfg=188 guifg=#dad8d8
    DevIconGDScript                            { fg="#6d8086", }, -- DevIconGDScript xxx ctermfg=66 guifg=#6d8086
    DevIconBazelBuild                          { fg="#89e051", }, -- DevIconBazelBuild xxx ctermfg=113 guifg=#89e051
    DevIconBzl                                 { fg="#89e051", }, -- DevIconBzl     xxx ctermfg=113 guifg=#89e051
    DevIconTextResource                        { fg="#cbcb41", }, -- DevIconTextResource xxx ctermfg=185 guifg=#cbcb41
    DevIconTextScene                           { fg="#a074c4", }, -- DevIconTextScene xxx ctermfg=140 guifg=#a074c4
    DevIconMli                                 { fg="#e37933", }, -- DevIconMli     xxx ctermfg=166 guifg=#e37933
    DevIconSvelte                              { fg="#ff3e00", }, -- DevIconSvelte  xxx ctermfg=196 guifg=#ff3e00
    DevIconProlog                              { fg="#e4b854", }, -- DevIconProlog  xxx ctermfg=179 guifg=#e4b854
    DevIconClojureC                            { fg="#8dc149", }, -- DevIconClojureC xxx ctermfg=113 guifg=#8dc149
    DevIconFsi                                 { fg="#519aba", }, -- DevIconFsi     xxx ctermfg=74 guifg=#519aba
    DevIconConfiguration                       { fg="#ececec", }, -- DevIconConfiguration xxx ctermfg=255 guifg=#ececec
    DevIconHtm                                 { fg="#e34c26", }, -- DevIconHtm     xxx ctermfg=196 guifg=#e34c26
    DevIconDb                                  { fg="#dad8d8", }, -- DevIconDb      xxx ctermfg=188 guifg=#dad8d8
    DevIconTestTs                              { fg="#519aba", }, -- DevIconTestTs  xxx ctermfg=74 guifg=#519aba
    DevIconSpecTs                              { fg="#519aba", }, -- DevIconSpecTs  xxx ctermfg=74 guifg=#519aba
    DevIconToml                                { fg="#6d8086", }, -- DevIconToml    xxx ctermfg=66 guifg=#6d8086
    DevIconReScriptInterface                   { fg="#f55385", }, -- DevIconReScriptInterface xxx ctermfg=204 guifg=#f55385
    DevIconTwig                                { fg="#8dc149", }, -- DevIconTwig    xxx ctermfg=113 guifg=#8dc149
    DevIconFennel                              { fg="#fff3d7", }, -- DevIconFennel  xxx ctermfg=230 guifg=#fff3d7
    DevIconRss                                 { fg="#fb9d3b", }, -- DevIconRss     xxx ctermfg=215 guifg=#fb9d3b
    DevIconDefault                             { fg="#6d8086", }, -- DevIconDefault xxx ctermfg=66 guifg=#6d8086
    DevIconXul                                 { fg="#e37933", }, -- DevIconXul     xxx ctermfg=166 guifg=#e37933
    DevIconHxx                                 { fg="#a074c4", }, -- DevIconHxx     xxx ctermfg=140 guifg=#a074c4
    DevIconVala                                { fg="#7239b3", }, -- DevIconVala    xxx ctermfg=91 guifg=#7239b3
    DevIconMakefile                            { fg="#6d8086", }, -- DevIconMakefile xxx ctermfg=66 guifg=#6d8086
    DevIconVue                                 { fg="#8dc149", }, -- DevIconVue     xxx ctermfg=113 guifg=#8dc149
    DevIconGruntfile                           { fg="#e37933", }, -- DevIconGruntfile xxx ctermfg=166 guifg=#e37933
    DevIconVHDL                                { fg="#019833", }, -- DevIconVHDL    xxx ctermfg=28 guifg=#019833
    DevIconEnv                                 { fg="#faf743", }, -- DevIconEnv     xxx ctermfg=227 guifg=#faf743
    DevIconBashrc                              { fg="#89e051", }, -- DevIconBashrc  xxx ctermfg=113 guifg=#89e051
    DevIconYaml                                { fg="#6d8086", }, -- DevIconYaml    xxx ctermfg=66 guifg=#6d8086
    DevIconFortran                             { fg="#734f96", }, -- DevIconFortran xxx ctermfg=97 guifg=#734f96
    DevIconRakefile                            { fg="#701516", }, -- DevIconRakefile xxx ctermfg=52 guifg=#701516
    DevIconBat                                 { fg="#c1f12e", }, -- DevIconBat     xxx ctermfg=191 guifg=#c1f12e
    DevIconImportConfiguration                 { fg="#ececec", }, -- DevIconImportConfiguration xxx ctermfg=255 guifg=#ececec
    DevIconTerminal                            { fg="#31b53e", }, -- DevIconTerminal xxx ctermfg=34 guifg=#31b53e
    DevIconCrystal                             { fg="#c8c8c8", }, -- DevIconCrystal xxx ctermfg=251 guifg=#c8c8c8
    DevIconDiff                                { fg="#41535b", }, -- DevIconDiff    xxx ctermfg=239 guifg=#41535b
    DevIconHh                                  { fg="#a074c4", }, -- DevIconHh      xxx ctermfg=140 guifg=#a074c4
    DevIconTypeScriptReactTest                 { fg="#1354bf", }, -- DevIconTypeScriptReactTest xxx ctermfg=26 guifg=#1354bf
    DevIconTypeScriptReactSpec                 { fg="#1354bf", }, -- DevIconTypeScriptReactSpec xxx ctermfg=26 guifg=#1354bf
    DevIconFsx                                 { fg="#519aba", }, -- DevIconFsx     xxx ctermfg=74 guifg=#519aba
    DevIconVlang                               { fg="#5d87bf", }, -- DevIconVlang   xxx ctermfg=67 guifg=#5d87bf
    DevIconQuery                               { fg="#90a850", }, -- DevIconQuery   xxx ctermfg=107 guifg=#90a850
    DevIconSml                                 { fg="#e37933", }, -- DevIconSml     xxx ctermfg=166 guifg=#e37933
    DevIconJson                                { fg="#cbcb41", }, -- DevIconJson    xxx ctermfg=185 guifg=#cbcb41
    DevIconVim                                 { fg="#019833", }, -- DevIconVim     xxx ctermfg=28 guifg=#019833
    DevIconIco                                 { fg="#cbcb41", }, -- DevIconIco     xxx ctermfg=185 guifg=#cbcb41
    DevIconWebp                                { fg="#a074c4", }, -- DevIconWebp    xxx ctermfg=140 guifg=#a074c4
    DevIconXcPlayground                        { fg="#e37933", }, -- DevIconXcPlayground xxx ctermfg=166 guifg=#e37933
    DevIconYml                                 { fg="#6d8086", }, -- DevIconYml     xxx ctermfg=66 guifg=#6d8086
    DevIconXls                                 { fg="#207245", }, -- DevIconXls     xxx ctermfg=29 guifg=#207245
    DevIconJpeg                                { fg="#a074c4", }, -- DevIconJpeg    xxx ctermfg=140 guifg=#a074c4
    DevIconXlsx                                { fg="#207245", }, -- DevIconXlsx    xxx ctermfg=29 guifg=#207245
    DevIconJpg                                 { fg="#a074c4", }, -- DevIconJpg     xxx ctermfg=140 guifg=#a074c4
    DevIconTestJs                              { fg="#cbcb41", }, -- DevIconTestJs  xxx ctermfg=185 guifg=#cbcb41
    DevIconPp                                  { fg="#ffa61a", }, -- DevIconPp      xxx guifg=#ffa61a
    DevIconSpecJs                              { fg="#cbcb41", }, -- DevIconSpecJs  xxx ctermfg=185 guifg=#cbcb41
    DevIconR                                   { fg="#358a5b", }, -- DevIconR       xxx ctermfg=29 guifg=#358a5b
    DevIconH                                   { fg="#a074c4", }, -- DevIconH       xxx ctermfg=140 guifg=#a074c4
    DevIconLock                                { fg="#bbbbbb", }, -- DevIconLock    xxx ctermfg=250 guifg=#bbbbbb
    DevIconBash                                { fg="#89e051", }, -- DevIconBash    xxx ctermfg=113 guifg=#89e051
    DevIconJavaScriptReactTest                 { fg="#20c2e3", }, -- DevIconJavaScriptReactTest xxx ctermfg=45 guifg=#20c2e3
    DevIconJavaScriptReactSpec                 { fg="#20c2e3", }, -- DevIconJavaScriptReactSpec xxx ctermfg=45 guifg=#20c2e3
    DevIconTFVars                              { fg="#5f43e9", }, -- DevIconTFVars  xxx ctermfg=93 guifg=#5f43e9
    DevIconWasm                                { fg="#5c4cdb", }, -- DevIconWasm    xxx ctermfg=62 guifg=#5c4cdb
    DevIconFs                                  { fg="#519aba", }, -- DevIconFs      xxx ctermfg=74 guifg=#519aba
    DevIconLog                                 { fg="#ffffff", }, -- DevIconLog     xxx ctermfg=231 guifg=#ffffff
    DevIconScheme                              { fg="#000000", }, -- DevIconScheme  xxx ctermfg=16 guifg=#000000
    DevIconFsscript                            { fg="#519aba", }, -- DevIconFsscript xxx ctermfg=74 guifg=#519aba
    DevIconMarkdown                            { fg="#519aba", }, -- DevIconMarkdown xxx ctermfg=74 guifg=#519aba
    DevIconRmd                                 { fg="#519aba", }, -- DevIconRmd     xxx ctermfg=74 guifg=#519aba
    DevIconMaterial                            { fg="#b83998", }, -- DevIconMaterial xxx ctermfg=163 guifg=#b83998
    DevIconSuo                                 { fg="#e37933", }, -- DevIconSuo     xxx ctermfg=166 guifg=#e37933
    DevIconRs                                  { fg="#dea584", }, -- DevIconRs      xxx ctermfg=216 guifg=#dea584
    DevIconRake                                { fg="#701516", }, -- DevIconRake    xxx ctermfg=52 guifg=#701516
    DevIconSvg                                 { fg="#ffb13b", }, -- DevIconSvg     xxx ctermfg=214 guifg=#ffb13b
    DevIconGemspec                             { fg="#701516", }, -- DevIconGemspec xxx ctermfg=52 guifg=#701516
    DevIconMdx                                 { fg="#519aba", }, -- DevIconMdx     xxx ctermfg=74 guifg=#519aba
    DevIconHrl                                 { fg="#b83998", }, -- DevIconHrl     xxx ctermfg=163 guifg=#b83998
    DevIconMint                                { fg="#87c095", }, -- DevIconMint    xxx ctermfg=108 guifg=#87c095
    DevIconWebpack                             { fg="#519aba", }, -- DevIconWebpack xxx ctermfg=74 guifg=#519aba
    DevIconSystemVerilog                       { fg="#019833", }, -- DevIconSystemVerilog xxx ctermfg=28 guifg=#019833
    DevIconStyl                                { fg="#8dc149", }, -- DevIconStyl    xxx ctermfg=113 guifg=#8dc149
    DevIconBashProfile                         { fg="#89e051", }, -- DevIconBashProfile xxx ctermfg=113 guifg=#89e051
    DevIconTxt                                 { fg="#89e051", }, -- DevIconTxt     xxx ctermfg=113 guifg=#89e051
    DevIconClojureDart                         { fg="#519aba", }, -- DevIconClojureDart xxx ctermfg=74 guifg=#519aba
    DevIconSolidity                            { fg="#519aba", }, -- DevIconSolidity xxx ctermfg=74 guifg=#519aba
    DevIconCoffee                              { fg="#cbcb41", }, -- DevIconCoffee  xxx ctermfg=185 guifg=#cbcb41
    DevIconGo                                  { fg="#519aba", }, -- DevIconGo      xxx ctermfg=74 guifg=#519aba
    DevIconDsStore                             { fg="#41535b", }, -- DevIconDsStore xxx ctermfg=239 guifg=#41535b
    DevIconConfigRu                            { fg="#701516", }, -- DevIconConfigRu xxx ctermfg=52 guifg=#701516
    DevIconMustache                            { fg="#e37933", }, -- DevIconMustache xxx ctermfg=166 guifg=#e37933
    DevIconCp                                  { fg="#519aba", }, -- DevIconCp      xxx ctermfg=74 guifg=#519aba
    DevIconC                                   { fg="#599eff", }, -- DevIconC       xxx ctermfg=111 guifg=#599eff
    DevIconKotlin                              { fg="#7f52ff", }, -- DevIconKotlin  xxx ctermfg=99 guifg=#7f52ff
    DevIconVerilog                             { fg="#019833", }, -- DevIconVerilog xxx ctermfg=28 guifg=#019833
    DevIconLicense                             { fg="#d0bf41", }, -- DevIconLicense xxx ctermfg=185 guifg=#d0bf41
    DevIconAwk                                 { fg="#4d5a5e", }, -- DevIconAwk     xxx ctermfg=240 guifg=#4d5a5e
    DevIconOPUS                                { fg="#f88a02", }, -- DevIconOPUS    xxx ctermfg=208 guifg=#f88a02
    DevIconGitLogo                             { fg="#f14c28", }, -- DevIconGitLogo xxx ctermfg=196 guifg=#f14c28
    DevIconBmp                                 { fg="#a074c4", }, -- DevIconBmp     xxx ctermfg=140 guifg=#a074c4
    DevIconCson                                { fg="#cbcb41", }, -- DevIconCson    xxx ctermfg=185 guifg=#cbcb41
    DevIconMd                                  { fg="#ffffff", }, -- DevIconMd      xxx ctermfg=231 guifg=#ffffff
    DevIconPhp                                 { fg="#a074c4", }, -- DevIconPhp     xxx ctermfg=140 guifg=#a074c4
    DevIconPsScriptModulefile                  { fg="#6975c4", }, -- DevIconPsScriptModulefile xxx ctermfg=68 guifg=#6975c4
    DevIconIni                                 { fg="#6d8086", }, -- DevIconIni     xxx ctermfg=66 guifg=#6d8086
    DevIconOpenTypeFont                        { fg="#ececec", }, -- DevIconOpenTypeFont xxx ctermfg=255 guifg=#ececec
    DevIconGif                                 { fg="#a074c4", }, -- DevIconGif     xxx ctermfg=140 guifg=#a074c4
    DevIconGvimrc                              { fg="#019833", }, -- DevIconGvimrc  xxx ctermfg=28 guifg=#019833
    DevIconPackedResource                      { fg="#6d8086", }, -- DevIconPackedResource xxx ctermfg=66 guifg=#6d8086
    DevIconZig                                 { fg="#f69a1b", }, -- DevIconZig     xxx ctermfg=172 guifg=#f69a1b
    DevIconEdn                                 { fg="#519aba", }, -- DevIconEdn     xxx ctermfg=74 guifg=#519aba
    DevIconVimrc                               { fg="#019833", }, -- DevIconVimrc   xxx ctermfg=28 guifg=#019833
    DevIconClojureJS                           { fg="#519aba", }, -- DevIconClojureJS xxx ctermfg=74 guifg=#519aba
    DevIconEex                                 { fg="#a074c4", }, -- DevIconEex     xxx ctermfg=140 guifg=#a074c4
    DevIconMotoko                              { fg="#9772fb", }, -- DevIconMotoko  xxx ctermfg=135 guifg=#9772fb
    DevIconMl                                  { fg="#e37933", }, -- DevIconMl      xxx ctermfg=166 guifg=#e37933
    DevIconNim                                 { fg="#f3d400", }, -- DevIconNim     xxx ctermfg=220 guifg=#f3d400
    DevIconSettingsJson                        { fg="#854cc7", }, -- DevIconSettingsJson xxx ctermfg=98 guifg=#854cc7
    DevIconPng                                 { fg="#a074c4", }, -- DevIconPng     xxx ctermfg=140 guifg=#a074c4
    DevIconCs                                  { fg="#596706", }, -- DevIconCs      xxx ctermfg=58 guifg=#596706
    DevIconDoc                                 { fg="#185abd", }, -- DevIconDoc     xxx ctermfg=26 guifg=#185abd
    DevIconSvelteConfig                        { fg="#ff3e00", }, -- DevIconSvelteConfig xxx ctermfg=196 guifg=#ff3e00
    DevIconTsx                                 { fg="#1354bf", }, -- DevIconTsx     xxx ctermfg=26 guifg=#1354bf
    DevIconsbt                                 { fg="#cc3e44", }, -- DevIconsbt     xxx ctermfg=167 guifg=#cc3e44
    DevIconLiquid                              { fg="#95bf47", }, -- DevIconLiquid  xxx ctermfg=106 guifg=#95bf47
    DevIconCMake                               { fg="#6d8086", }, -- DevIconCMake   xxx ctermfg=66 guifg=#6d8086
    DevIconDropbox                             { fg="#0061fe", }, -- DevIconDropbox xxx ctermfg=27 guifg=#0061fe
    DevIconCjs                                 { fg="#cbcb41", }, -- DevIconCjs     xxx ctermfg=185 guifg=#cbcb41
    DevIconClojure                             { fg="#8dc149", }, -- DevIconClojure xxx ctermfg=113 guifg=#8dc149
    DevIconSass                                { fg="#f55385", }, -- DevIconSass    xxx ctermfg=204 guifg=#f55385
    DevIconPsb                                 { fg="#519aba", }, -- DevIconPsb     xxx ctermfg=74 guifg=#519aba
    DevIconGitlabCI                            { fg="#e24329", }, -- DevIconGitlabCI xxx ctermfg=196 guifg=#e24329
    DevIconCMakeLists                          { fg="#6d8086", }, -- DevIconCMakeLists xxx ctermfg=66 guifg=#6d8086
    DevIconPsd                                 { fg="#519aba", }, -- DevIconPsd     xxx ctermfg=74 guifg=#519aba
    DevIconGitCommit                           { fg="#41535b", }, -- DevIconGitCommit xxx ctermfg=239 guifg=#41535b
    DevIconEjs                                 { fg="#cbcb41", }, -- DevIconEjs     xxx ctermfg=185 guifg=#cbcb41
    DevIconPyc                                 { fg="#ffe291", }, -- DevIconPyc     xxx ctermfg=222 guifg=#ffe291
    DevIconHpp                                 { fg="#a074c4", }, -- DevIconHpp     xxx ctermfg=140 guifg=#a074c4
    DevIconNPMIgnore                           { fg="#e8274b", }, -- DevIconNPMIgnore xxx ctermfg=197 guifg=#e8274b
    DevIconPyd                                 { fg="#ffe291", }, -- DevIconPyd     xxx ctermfg=222 guifg=#ffe291
    DevIconPyo                                 { fg="#ffe291", }, -- DevIconPyo     xxx ctermfg=222 guifg=#ffe291
    DevIconKotlinScript                        { fg="#7f52ff", }, -- DevIconKotlinScript xxx ctermfg=99 guifg=#7f52ff
    DevIconJl                                  { fg="#a270ba", }, -- DevIconJl      xxx ctermfg=133 guifg=#a270ba
    DevIconFsharp                              { fg="#519aba", }, -- DevIconFsharp  xxx ctermfg=74 guifg=#519aba
    DevIconDocx                                { fg="#185abd", }, -- DevIconDocx    xxx ctermfg=26 guifg=#185abd
    DevIconPpt                                 { fg="#cb4a32", }, -- DevIconPpt     xxx ctermfg=214 guifg=#cb4a32
    DevIconBazel                               { fg="#89e051", }, -- DevIconBazel   xxx ctermfg=113 guifg=#89e051
    DevIconWebmanifest                         { fg="#f1e05a", }, -- DevIconWebmanifest xxx ctermfg=185 guifg=#f1e05a
    DevIconGulpfile                            { fg="#cc3e44", }, -- DevIconGulpfile xxx ctermfg=167 guifg=#cc3e44
    DevIconRlib                                { fg="#dea584", }, -- DevIconRlib    xxx ctermfg=216 guifg=#dea584
    DevIconVagrantfile                         { fg="#1563ff", }, -- DevIconVagrantfile xxx ctermfg=27 guifg=#1563ff
    DevIconDrools                              { fg="#ffafaf", }, -- DevIconDrools  xxx ctermfg=217 guifg=#ffafaf
    DevIconTs                                  { fg="#519aba", }, -- DevIconTs      xxx ctermfg=74 guifg=#519aba
    DevIconBrewfile                            { fg="#701516", }, -- DevIconBrewfile xxx ctermfg=52 guifg=#701516
    DevIconRproj                               { fg="#358a5b", }, -- DevIconRproj   xxx ctermfg=29 guifg=#358a5b
    DevIconConf                                { fg="#6d8086", }, -- DevIconConf    xxx ctermfg=66 guifg=#6d8086
    DevIconCsh                                 { fg="#4d5a5e", }, -- DevIconCsh     xxx ctermfg=240 guifg=#4d5a5e
    DevIconTor                                 { fg="#519aba", }, -- DevIconTor     xxx ctermfg=74 guifg=#519aba
    DevIconPackageLockJson                     { fg="#7a0d21", }, -- DevIconPackageLockJson xxx guifg=#7a0d21
    DevIconXml                                 { fg="#e37933", }, -- DevIconXml     xxx ctermfg=166 guifg=#e37933
    DevIconJs                                  { fg="#cbcb41", }, -- DevIconJs      xxx ctermfg=185 guifg=#cbcb41
    DevIconMjs                                 { fg="#f1e05a", }, -- DevIconMjs     xxx ctermfg=185 guifg=#f1e05a
    DevIconBinaryGLTF                          { fg="#ffb13b", }, -- DevIconBinaryGLTF xxx ctermfg=214 guifg=#ffb13b
    DevIconFavicon                             { fg="#cbcb41", }, -- DevIconFavicon xxx ctermfg=185 guifg=#cbcb41
    DevIconAi                                  { fg="#cbcb41", }, -- DevIconAi      xxx ctermfg=185 guifg=#cbcb41
    DevIconHtml                                { fg="#e44d26", }, -- DevIconHtml    xxx ctermfg=196 guifg=#e44d26
    DevIconCxx                                 { fg="#519aba", }, -- DevIconCxx     xxx ctermfg=74 guifg=#519aba
    DevIconGodotProject                        { fg="#6d8086", }, -- DevIconGodotProject xxx ctermfg=66 guifg=#6d8086
    DevIconJsx                                 { fg="#20c2e3", }, -- DevIconJsx     xxx ctermfg=45 guifg=#20c2e3
    DevIconSlim                                { fg="#e34c26", }, -- DevIconSlim    xxx ctermfg=196 guifg=#e34c26
    DevIconLua                                 { fg="#51a0cf", }, -- DevIconLua     xxx ctermfg=74 guifg=#51a0cf
    DevIconGemfile                             { fg="#701516", }, -- DevIconGemfile xxx ctermfg=52 guifg=#701516
    DevIconProcfile                            { fg="#a074c4", }, -- DevIconProcfile xxx ctermfg=140 guifg=#a074c4
    DevIconSln                                 { fg="#854cc7", }, -- DevIconSln     xxx ctermfg=98 guifg=#854cc7
    DevIconErb                                 { fg="#701516", }, -- DevIconErb     xxx ctermfg=214 guifg=#701516
    DevIconEx                                  { fg="#a074c4", }, -- DevIconEx      xxx ctermfg=140 guifg=#a074c4
    DevIconPl                                  { fg="#519aba", }, -- DevIconPl      xxx ctermfg=74 guifg=#519aba
    DevIconErl                                 { fg="#b83998", }, -- DevIconErl     xxx ctermfg=163 guifg=#b83998
    DevIconEpp                                 { fg="#ffa61a", }, -- DevIconEpp     xxx guifg=#ffa61a
    DevIconCsv                                 { fg="#89e051", }, -- DevIconCsv     xxx ctermfg=113 guifg=#89e051
    lualine_y_filetype_DevIconDefault_normal   { bg="#303030", fg="#6d8086", }, -- lualine_y_filetype_DevIconDefault_normal xxx guifg=#6d8086 guibg=#303030
    lualine_y_filetype_DevIconDefault_insert   { bg="#303030", fg="#6d8086", }, -- lualine_y_filetype_DevIconDefault_insert xxx guifg=#6d8086 guibg=#303030
    lualine_y_filetype_DevIconDefault_visual   { bg="#303030", fg="#6d8086", }, -- lualine_y_filetype_DevIconDefault_visual xxx guifg=#6d8086 guibg=#303030
    lualine_y_filetype_DevIconDefault_replace  { bg="#303030", fg="#6d8086", }, -- lualine_y_filetype_DevIconDefault_replace xxx guifg=#6d8086 guibg=#303030
    lualine_y_filetype_DevIconDefault_command  { bg="#303030", fg="#6d8086", }, -- lualine_y_filetype_DevIconDefault_command xxx guifg=#6d8086 guibg=#303030
    lualine_y_filetype_DevIconDefault_terminal { bg="#303030", fg="#6d8086", }, -- lualine_y_filetype_DevIconDefault_terminal xxx guifg=#6d8086 guibg=#303030
    lualine_y_filetype_DevIconDefault_inactive { bg="#080808", fg="#6d8086", }, -- lualine_y_filetype_DevIconDefault_inactive xxx guifg=#6d8086 guibg=#080808
    htmlStrike                                 { gui="strikethrough", }, -- htmlStrike     xxx cterm=strikethrough gui=strikethrough
    markdownStrike                             { htmlStrike }, -- markdownStrike xxx links to htmlStrike
    htmlBoldUnderline                          { gui="bold,underline", }, -- htmlBoldUnderline xxx cterm=bold,underline gui=bold,underline
    htmlUnderlineBold                          { htmlBoldUnderline }, -- htmlUnderlineBold xxx links to htmlBoldUnderline
    htmlBoldItalic                             { gui="bold,italic", }, -- htmlBoldItalic xxx cterm=bold,italic gui=bold,italic
    htmlItalicBold                             { htmlBoldItalic }, -- htmlItalicBold xxx links to htmlBoldItalic
    markdownBoldItalic                         { htmlBoldItalic }, -- markdownBoldItalic xxx links to htmlBoldItalic
    htmlBold                                   { gui="bold", }, -- htmlBold       xxx cterm=bold gui=bold
    markdownBold                               { htmlBold }, -- markdownBold   xxx links to htmlBold
    htmlBoldUnderlineItalic                    { gui="bold,underline,italic", }, -- htmlBoldUnderlineItalic xxx cterm=bold,underline,italic gui=bold,underline,italic
    htmlBoldItalicUnderline                    { htmlBoldUnderlineItalic }, -- htmlBoldItalicUnderline xxx links to htmlBoldUnderlineItalic
    htmlUnderlineBoldItalic                    { htmlBoldUnderlineItalic }, -- htmlUnderlineBoldItalic xxx links to htmlBoldUnderlineItalic
    htmlUnderlineItalicBold                    { htmlBoldUnderlineItalic }, -- htmlUnderlineItalicBold xxx links to htmlBoldUnderlineItalic
    htmlItalicBoldUnderline                    { htmlBoldUnderlineItalic }, -- htmlItalicBoldUnderline xxx links to htmlBoldUnderlineItalic
    htmlItalicUnderlineBold                    { htmlBoldUnderlineItalic }, -- htmlItalicUnderlineBold xxx links to htmlBoldUnderlineItalic
    htmlUnderlineItalic                        { gui="underline,italic", }, -- htmlUnderlineItalic xxx cterm=underline,italic gui=underline,italic
    htmlItalicUnderline                        { htmlUnderlineItalic }, -- htmlItalicUnderline xxx links to htmlUnderlineItalic
    htmlUnderline                              { gui="underline", }, -- htmlUnderline  xxx cterm=underline gui=underline
    htmlItalic                                 { gui="italic", }, -- htmlItalic     xxx cterm=italic gui=italic
    markdownItalic                             { htmlItalic }, -- markdownItalic xxx links to htmlItalic
    lualine_y_filetype_DevIconMd_normal        { bg="#303030", fg="#ffffff", }, -- lualine_y_filetype_DevIconMd_normal xxx guifg=#ffffff guibg=#303030
    lualine_y_filetype_DevIconMd_insert        { bg="#303030", fg="#ffffff", }, -- lualine_y_filetype_DevIconMd_insert xxx guifg=#ffffff guibg=#303030
    lualine_y_filetype_DevIconMd_visual        { bg="#303030", fg="#ffffff", }, -- lualine_y_filetype_DevIconMd_visual xxx guifg=#ffffff guibg=#303030
    lualine_y_filetype_DevIconMd_replace       { bg="#303030", fg="#ffffff", }, -- lualine_y_filetype_DevIconMd_replace xxx guifg=#ffffff guibg=#303030
    lualine_y_filetype_DevIconMd_command       { bg="#303030", fg="#ffffff", }, -- lualine_y_filetype_DevIconMd_command xxx guifg=#ffffff guibg=#303030
    lualine_y_filetype_DevIconMd_terminal      { bg="#303030", fg="#ffffff", }, -- lualine_y_filetype_DevIconMd_terminal xxx guifg=#ffffff guibg=#303030
    lualine_y_filetype_DevIconMd_inactive      { bg="#080808", fg="#ffffff", }, -- lualine_y_filetype_DevIconMd_inactive xxx guifg=#ffffff guibg=#080808
    lualine_y_filetype_DevIconTxt_normal       { bg="#303030", fg="#89e051", }, -- lualine_y_filetype_DevIconTxt_normal xxx guifg=#89e051 guibg=#303030
    lualine_y_filetype_DevIconTxt_insert       { bg="#303030", fg="#89e051", }, -- lualine_y_filetype_DevIconTxt_insert xxx guifg=#89e051 guibg=#303030
    lualine_y_filetype_DevIconTxt_visual       { bg="#303030", fg="#89e051", }, -- lualine_y_filetype_DevIconTxt_visual xxx guifg=#89e051 guibg=#303030
    lualine_y_filetype_DevIconTxt_replace      { bg="#303030", fg="#89e051", }, -- lualine_y_filetype_DevIconTxt_replace xxx guifg=#89e051 guibg=#303030
    lualine_y_filetype_DevIconTxt_command      { bg="#303030", fg="#89e051", }, -- lualine_y_filetype_DevIconTxt_command xxx guifg=#89e051 guibg=#303030
    lualine_y_filetype_DevIconTxt_terminal     { bg="#303030", fg="#89e051", }, -- lualine_y_filetype_DevIconTxt_terminal xxx guifg=#89e051 guibg=#303030
    lualine_y_filetype_DevIconTxt_inactive     { bg="#080808", fg="#89e051", }, -- lualine_y_filetype_DevIconTxt_inactive xxx guifg=#89e051 guibg=#080808
  }
end)

return theme

