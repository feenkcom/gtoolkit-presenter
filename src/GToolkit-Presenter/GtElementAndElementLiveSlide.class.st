"
I am an element and element live slide. I get two elements and display them, one on the left and one on the right.

{{gtMethod:GtExampleLiveShow>>#elementAndElementExampleSlideFor:|expanded=}}


"
Class {
	#name : 'GtElementAndElementLiveSlide',
	#superclass : 'GtLiveSlide',
	#instVars : [
		'leftElementBlock',
		'rightElementBlock',
		'textPieces'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtElementAndElementLiveSlide >> create [
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

{ #category : 'initialization' }
GtElementAndElementLiveSlide >> initialize [
	super initialize.
	textPieces := OrderedCollection new.
	self leftElement: BlElement new.
	self rightElement: BlElement new.
]

{ #category : 'accessing' }
GtElementAndElementLiveSlide >> leftElement: anElement [
	leftElementBlock := anElement.
]

{ #category : 'accessing' }
GtElementAndElementLiveSlide >> newText: aText [
	self newTextWithFormat: (aText asRopedText glamorousRegularFontAndSize; foreground: Color gray)
]

{ #category : 'accessing' }
GtElementAndElementLiveSlide >> newTextWithFormat: aText [
	textPieces add: aText asRopedText.
]

{ #category : 'accessing' }
GtElementAndElementLiveSlide >> rightElement: anElement [
	rightElementBlock := anElement.
]
