Class {
	#name : 'GtYellowCircleExplanationTextAdornment',
	#superclass : 'BrTextAdornmentAttribute',
	#instVars : [
		'identifier',
		'circleSize'
	],
	#category : 'GToolkit-Explainer-Coder add-on'
}

{ #category : 'instance creation' }
GtYellowCircleExplanationTextAdornment class >> forIdentifier: anIdentifier [
	^ self forIdentifier: anIdentifier withSize: 3.
]

{ #category : 'instance creation' }
GtYellowCircleExplanationTextAdornment class >> forIdentifier: anIdentifier withSize: aSize [
	^ self new
		size: aSize;
		identifier: anIdentifier;
		yourself.
]

{ #category : 'accessing' }
GtYellowCircleExplanationTextAdornment >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| circleElement |
	
	circleElement := BrButton new
		geometry: BlEllipseGeometry new;
		size: circleSize@circleSize;
		aptitude: (GtExplainerTargetAptitude new explanationModel: identifier).
	
	^ circleElement
]

{ #category : 'accessing' }
GtYellowCircleExplanationTextAdornment >> identifier [
	^ identifier.
]

{ #category : 'accessing' }
GtYellowCircleExplanationTextAdornment >> identifier: anIdentifier [
	identifier := anIdentifier.
]

{ #category : 'initialization' }
GtYellowCircleExplanationTextAdornment >> initialize [
	super initialize.
	self beAppend.
	
	circleSize := 3.0
]

{ #category : 'accessing' }
GtYellowCircleExplanationTextAdornment >> size [
	^ circleSize.
]

{ #category : 'accessing' }
GtYellowCircleExplanationTextAdornment >> size: aSize [
	circleSize := aSize.
]
