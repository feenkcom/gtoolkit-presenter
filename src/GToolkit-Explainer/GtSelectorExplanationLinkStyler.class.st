"
I add a yellow circle adornment to selectors in a text. The selectors are pragma nodes, literal nodes and message nodes.


"
Class {
	#name : #GtSelectorExplanationLinkStyler,
	#superclass : #GtSourceExplanationLinkStyler,
	#instVars : [
		'selectorsDictionary'
	],
	#category : #'GToolkit-Explainer-Coder add-on'
}

{ #category : #visiting }
GtSelectorExplanationLinkStyler >> addExplanationAttributeFor: aNode withIdentifier: anIdentifier [
	| anAttribute |

	anAttribute := self shouldAddUnderline
		ifTrue: [
			GtTargetCircleWithUnderlineAdornment new
				identifier: anIdentifier;
				coder: self coderViewModel coderModel;
				node: aNode;
				start: aNode startPosition;
				stop: aNode stopPosition ]
		ifFalse: [
			GtYellowCircleExplanationTextAdornment
				forIdentifier: anIdentifier ].

	self
		attribute: anAttribute
		from: aNode startPosition
		to: aNode stopPosition
]

{ #category : #accessing }
GtSelectorExplanationLinkStyler >> addSelector: aSymbol [	
	self addSelector: aSymbol withIdentifier: aSymbol.
]

{ #category : #adding }
GtSelectorExplanationLinkStyler >> addSelector: aSymbol withIdentifier: anIdentifier [
	selectorsDictionary at: aSymbol put: anIdentifier.
]

{ #category : #adding }
GtSelectorExplanationLinkStyler >> addSelectors: aCollection [
	aCollection do: [ :selector | self addSelector: selector ]
]

{ #category : #initialization }
GtSelectorExplanationLinkStyler >> initialize [
	super initialize.

	selectorsDictionary := Dictionary new
]

{ #category : #accessing }
GtSelectorExplanationLinkStyler >> selectorsAssociations [
	^ selectorsDictionary associations.
]

{ #category : #asserting }
GtSelectorExplanationLinkStyler >> shouldAddUnderline [
	^ self coderViewModel compiledMethod notNil
]

{ #category : #visiting }
GtSelectorExplanationLinkStyler >> visitMessage: aMessageNode [
	super visitMessage: aMessageNode.
	
	self
		visitNode: aMessageNode
		withSelector: aMessageNode selector
]

{ #category : #visiting }
GtSelectorExplanationLinkStyler >> visitNode: aNode withSelector: aSelector [
	| anAttribute aSelectorIdentifier |

	aSelectorIdentifier := selectorsDictionary
		at: aSelector
		ifAbsent: [ ^ self ].

	anAttribute := self shouldAddUnderline
		ifTrue: [
			GtTargetCircleWithUnderlineAdornment new
				identifier: aSelectorIdentifier;
				coder: self coderViewModel coderModel;
				node: aNode;
				start: aNode startPosition;
				stop: aNode stopPosition ]
		ifFalse: [
			GtYellowCircleExplanationTextAdornment
				forIdentifier: aSelectorIdentifier ].

	self
		attribute: anAttribute
		from: aNode startPosition - 1
		to: aNode startPosition - 1
]

{ #category : #visiting }
GtSelectorExplanationLinkStyler >> visitPragma: aPragmaNode [
	super visitPragma: aPragmaNode.

	self
		visitNode: aPragmaNode
		withSelector: aPragmaNode selector
]
