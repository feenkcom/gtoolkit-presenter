Class {
	#name : #GtPharoSyntaxExplanationStyler,
	#superclass : #GtSourceExplanationLinkStyler,
	#instVars : [
		'detectedConstructs'
	],
	#category : #'GToolkit-Explainer-Coder add-on'
}

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> circleBefore: aNode identifier: aSymbol [
	self detectedConstructs add: aSymbol.
	(text
		from: aNode startPosition - 1
		to: aNode startPosition - 1)
		attribute: (GtYellowCircleExplanationTextAdornment new identifier: aSymbol)
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> detectedConstructs [
	^ detectedConstructs ifNil: [ detectedConstructs := Set new ]
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitArray: anArray [
	super visitArray: anArray.
	self circleBefore: anArray identifier: #ArrayNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitArrayLiteral: anArrayLiteral [
	super visitArrayLiteral: anArrayLiteral.
	self circleBefore: anArrayLiteral identifier: #LiteralArrayNode.
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitAssignment: anAssignment [
	super visitAssignment: anAssignment.
	self circleBefore: anAssignment assignmentToken identifier: #AssignmentNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitBinaryMessage: aBinaryMessage [
	super visitBinaryMessage: aBinaryMessage.
	self circleBefore: aBinaryMessage identifier: #BinaryNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitBlock: aBlock [
	super visitBlock: aBlock.
	self circleBefore: aBlock identifier: #BlockNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitCascade: aCascade [
	super visitCascade: aCascade.
	aCascade semicolons do: [ :each |	
		self detectedConstructs add: #CascadeNode.
		(text
			from: each startPosition - 1
			to: each startPosition - 1)
			attribute: (GtYellowCircleExplanationTextAdornment new identifier: #CascadeNode)]
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitCharacterLiteral: aCharacterLiteral [
	super visitCharacterLiteral: aCharacterLiteral.
	self circleBefore: aCharacterLiteral identifier: #CharacterNode.
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitKeywordMessage: aKeyword [
	super visitKeywordMessage: aKeyword.
	self circleBefore: aKeyword identifier: #KeywordNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitNamedVariable: aNamedVariable [
	super visitNamedVariable: aNamedVariable.
	self circleBefore: aNamedVariable identifier: (
		aNamedVariable isLocallyDefined 
			ifFalse: [#GlobalNode]
			ifTrue: [aNamedVariable whoDefines isMethod ifTrue: [#ArgumentNode] ifFalse: [#TemporaryNode]])
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitNumberLiteral: aNumberLiteral [
	super visitNumberLiteral: aNumberLiteral.
	self circleBefore: aNumberLiteral identifier: (
		aNumberLiteral isIntegerValue
			ifTrue: [ #IntegerNode ]
			ifFalse: [ #FloatNode ])
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitPragma: aPragma [
	super visitPragma: aPragma.
	self circleBefore: aPragma identifier: #PragmaNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitProgram: aProgram [
	super visitProgram: aProgram.
	(aProgram comments ifNil: [{}]) do: [:aCommentNode | 
		self detectedConstructs add: #CommentNode.
		(text
			from: aCommentNode first - 1
			to: aCommentNode first - 1)
			attributes: { GtYellowCircleExplanationTextAdornment new identifier: #CommentNode} ].
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitReturn: aReturn [
	super visitReturn: aReturn.
	self circleBefore: aReturn identifier: #ReturnNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitSelfVariable: aSelf [
	super visitSelfVariable: aSelf.
	self circleBefore: aSelf identifier: #SelfNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitStringLiteral: aStringLiteral [
	super visitStringLiteral: aStringLiteral.
	self circleBefore: aStringLiteral identifier: #StringNode.
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitSuperVariable: aSuperVariable [
	super visitSuperVariable: aSuperVariable.
	self circleBefore: aSuperVariable identifier: #SuperNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitSymbol: aSymbol [
	super visitSymbol: aSymbol.
	self circleBefore: aSymbol identifier: #SymbolNode.
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitThisContextVariable: aThisContextVariable [
	super visitThisContextVariable: aThisContextVariable.
	self circleBefore: aThisContextVariable identifier: #ThisContextNode
]

{ #category : #accessing }
GtPharoSyntaxExplanationStyler >> visitUnaryMessage: anUnaryMessage [
	super visitUnaryMessage: anUnaryMessage.
	self circleBefore: anUnaryMessage identifier: #UnaryNode
]
