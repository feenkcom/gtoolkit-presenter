"
I am an abstract parent for slides with a label at the top.
"
Class {
	#name : #GtLabelAndEntityLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'textPieces'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtLabelAndEntityLiveSlide >> create [
	| container |
	container := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			padding: (BlInsets top: 20 bottom: 20);
			layout: BlLinearLayout vertical.
	textPieces
		do: [ :aText | 
			container
				addChild: (BlTextElement new
						margin: (BlInsets all: 1);
						constraintsDo: [ :c | 
							c vertical fitContent.
							c horizontal fitContent.
							c linear horizontal alignCenter ];
						text: aText) ].
	^ container
]

{ #category : #initialization }
GtLabelAndEntityLiveSlide >> initialize [
	super initialize.
	textPieces := OrderedCollection new
]

{ #category : #accessing }
GtLabelAndEntityLiveSlide >> newFadedText: aText [
	self newTextWithFormat: (aText asRopedText glamorousRegularFont; fontSize: 16; foreground: Color gray)
]

{ #category : #accessing }
GtLabelAndEntityLiveSlide >> newText: aText [
	self newTextWithFormat: (aText asRopedText glamorousRegularFontAndSize)
]

{ #category : #accessing }
GtLabelAndEntityLiveSlide >> newTextWithFormat: aText [
	textPieces add: aText asRopedText.
]
