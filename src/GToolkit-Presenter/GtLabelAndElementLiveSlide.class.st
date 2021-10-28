"
I am a lable and element live slide. I get a label in the form of a text and an element. The element is displayed in the center and the label is positioned on top.

{{gtMethod:GtExampleLiveShow>>#labelAndElementSlideFor:|expanded=}}


"
Class {
	#name : #GtLabelAndElementLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'elementBlock',
		'textPieces'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtLabelAndElementLiveSlide >> create [
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
			addChild: (elementBlock value asElement constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ])).
	^ container
]

{ #category : #accessing }
GtLabelAndElementLiveSlide >> element: anElement [
	elementBlock := anElement.
]

{ #category : #initialization }
GtLabelAndElementLiveSlide >> initialize [
	super initialize.
	textPieces := OrderedCollection new.
	self element: BlElement new.
]

{ #category : #accessing }
GtLabelAndElementLiveSlide >> newFadedText: aText [
	self newTextWithFormat: (aText asRopedText glamorousRegularFont; fontSize: 16; foreground: Color gray)
]

{ #category : #accessing }
GtLabelAndElementLiveSlide >> newText: aText [
	self newTextWithFormat: (aText asRopedText glamorousRegularFontAndSize)
]

{ #category : #accessing }
GtLabelAndElementLiveSlide >> newTextWithFormat: aText [
	textPieces add: aText asRopedText.
]
