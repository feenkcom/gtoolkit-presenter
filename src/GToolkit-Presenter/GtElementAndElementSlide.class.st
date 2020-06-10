Class {
	#name : #GtElementAndElementSlide,
	#superclass : #GtSlide,
	#instVars : [
		'leftElementBlock',
		'textPieces',
		'rightElementBlock'
	],
	#category : #'GToolkit-Presenter-GToolkit-Presenter'
}

{ #category : #accessing }
GtElementAndElementSlide >> create [
	| mainContainer container |
	mainContainer := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets top: 20 bottom: 20);
		layout: BlLinearLayout vertical.
	textPieces do: [ :aText |
		mainContainer addChild: (BlTextElement new
				margin: (BlInsets all: 1);
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal fitContent.
					c linear horizontal alignCenter];
				text: aText )].
	
	container := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets top: 20 bottom: 20);
		layout: BlLinearLayout horizontal.
	mainContainer
		addChild: container.
	container
		addChild: (BlElement new
			constraintsDo: [:ct |
				ct vertical matchParent.
				ct horizontal matchParent ];
			layout: BlLinearLayout vertical;
			margin: (BlInsets all: 20);
			addChild: (leftElementBlock value constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ]));
		addChild: (BlElement new
			constraintsDo: [:ct |
				ct vertical matchParent.
				ct horizontal matchParent ];
			layout: BlLinearLayout vertical;
			margin: (BlInsets all: 20);
			addChild: (rightElementBlock value constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ])).
	^ mainContainer
]

{ #category : #accessing }
GtElementAndElementSlide >> initialize [
	super initialize.
	textPieces := OrderedCollection new.
	self leftElement: BlElement new.
	self rightElement: BlElement new.
]

{ #category : #accessing }
GtElementAndElementSlide >> leftElement: anElement [
	leftElementBlock := anElement.
]

{ #category : #accessing }
GtElementAndElementSlide >> newText: aText [
	self newTextWithFormat: (aText asRopedText glamorousRegularFontAndSize)
]

{ #category : #accessing }
GtElementAndElementSlide >> newTextWithFormat: aText [
	textPieces add: aText asRopedText.
]

{ #category : #accessing }
GtElementAndElementSlide >> rightElement: anElement [
	rightElementBlock := anElement.
]
