"
I am a Slide designe that gets a Text and and Element and displays them. I can be included in presentations.
"
Class {
	#name : #GtLabelAndElementSlide,
	#superclass : #GtSlide,
	#instVars : [
		'elementBlock',
		'textPieces'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtLabelAndElementSlide >> create [
	| container |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets top: 20 bottom: 20);
		layout: BlLinearLayout vertical.
	textPieces do: [ :aText |
		container addChild: (BlTextElement new
				margin: (BlInsets all: 1);
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent.
					c linear horizontal alignCenter];
				text: aText )].
	container
		addChild: (BlElement new
			constraintsDo: [:ct |
				ct vertical matchParent.
				ct horizontal matchParent ];
			layout: BlLinearLayout vertical;
			margin: (BlInsets all: 20);
			addChild: (elementBlock value constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ])).
	^ container
]

{ #category : #accessing }
GtLabelAndElementSlide >> element: anElement [
	elementBlock := anElement.
]

{ #category : #initialization }
GtLabelAndElementSlide >> initialize [
	super initialize.
	textPieces := OrderedCollection new.
	self element: BlElement new.
]

{ #category : #accessing }
GtLabelAndElementSlide >> stencil: aBlock [
	elementBlock := aBlock.
]

{ #category : #accessing }
GtLabelAndElementSlide >> text: aText [
	self textWithFormat: (aText asRopedText fontSize: 30; glamorousRegularFont)
]

{ #category : #'as yet unclassified' }
GtLabelAndElementSlide >> textWithFormat: aText [
	textPieces add: aText.
]
