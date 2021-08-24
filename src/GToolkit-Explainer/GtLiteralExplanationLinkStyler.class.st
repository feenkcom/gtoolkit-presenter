"
I style literal nodes in a text with yellow circle adornments.


"
Class {
	#name : 'GtLiteralExplanationLinkStyler',
	#superclass : 'GtSourceExplanationLinkStyler',
	#instVars : [
		'literalsDictionary'
	],
	#category : 'GToolkit-Explainer-Coder add-on'
}

{ #category : 'adding' }
GtLiteralExplanationLinkStyler >> addLiteral: aSymbol [	
	self addLiteral: aSymbol withIdentifier: aSymbol.
]

{ #category : 'adding' }
GtLiteralExplanationLinkStyler >> addLiteral: aLiteralObject withIdentifier: anIdentifier [
	literalsDictionary at: aLiteralObject put: anIdentifier
]

{ #category : 'adding' }
GtLiteralExplanationLinkStyler >> addLiterals: aCollection [
	aCollection do: [ :literal | self addLiteral: literal ].
]

{ #category : 'initialization' }
GtLiteralExplanationLinkStyler >> initialize [
	super initialize.

	literalsDictionary := Dictionary new
]

{ #category : 'asserting' }
GtLiteralExplanationLinkStyler >> shouldAddUnderline [
	^ self coderViewModel compiledMethod notNil
]

{ #category : 'visiting' }
GtLiteralExplanationLinkStyler >> visitLiteral: aLiteralNode [
	| anAttribute aLiteralValue aLiteralIdentifier |
	super visitLiteral: aLiteralNode.

	aLiteralValue := aLiteralNode literalValue.
	aLiteralIdentifier := literalsDictionary
		at: aLiteralValue
		ifAbsent: [ ^ self ].

	anAttribute := self shouldAddUnderline
		ifTrue: [
			GtTargetCircleWithUnderlineAdornment new
				identifier: aLiteralIdentifier;
				coder: self coderViewModel coderModel;
				node: aLiteralNode;
				start: aLiteralNode startPosition;
				stop: aLiteralNode stopPosition ]
		ifFalse: [
			GtYellowCircleExplanationTextAdornment
				forIdentifier: aLiteralIdentifier ].

	self
		attribute: anAttribute
		from: aLiteralNode startPosition
		to: aLiteralNode stopPosition
]
