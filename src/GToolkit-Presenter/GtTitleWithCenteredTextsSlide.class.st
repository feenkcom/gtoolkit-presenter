"
Like a title slide but with as many centred texts below as you like.
"
Class {
	#name : #GtTitleWithCenteredTextsSlide,
	#superclass : #GtTitleLiveSlide,
	#instVars : [
		'texts',
		'textMargin',
		'subtitleBottomPadding',
		'textBottomPadding'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtTitleWithCenteredTextsSlide >> create [
	| container textContainer |
	container := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout horizontal.
	textContainer := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent.
				c linear vertical alignCenter ];
			layout: BlLinearLayout vertical.
	textContainer
		addChild: (BlTextElement new
				constraintsDo: [ :c | c linear horizontal alignCenter ];
				padding: (BlInsets
						top: 40;
						bottom: self titleBottomPadding);
				text: title).
	subtitle isEmpty
		ifFalse: [ textContainer
				addChild: (BlTextElement new
						constraintsDo: [ :c | c linear horizontal alignCenter ];
						padding: (BlInsets
								top: 40;
								bottom: self subtitleBottomPadding);
						text: subtitle) ].
	texts
		do: [ :aText | 
			textContainer
				addChild: (BlTextElement new
						constraintsDo: [ :c | c linear horizontal alignCenter ];
						padding: (BlInsets
								top: 40;
								bottom: self textBottomPadding);
						text: aText) ].
	container addChild: textContainer.
	^ container
]

{ #category : #initialization }
GtTitleWithCenteredTextsSlide >> defaultSubtitleBottomPadding [
	^ 40
]

{ #category : #initialization }
GtTitleWithCenteredTextsSlide >> defaultTextBottomPadding [
	^ 10
]

{ #category : #acccessing }
GtTitleWithCenteredTextsSlide >> defaultTextMargin [
	^ 50
]

{ #category : #initialization }
GtTitleWithCenteredTextsSlide >> initialize [
	super initialize.
	self subtitleBottomPadding: self defaultSubtitleBottomPadding.
	self textBottomPadding: self defaultTextBottomPadding.
	self textMargin: self defaultTextMargin.
	texts := OrderedCollection new
]

{ #category : #acccessing }
GtTitleWithCenteredTextsSlide >> newText: aRopedText [
	self newTextWithFormat: (aRopedText asRopedText glamorousRegularFont; fontSize: 20)
]

{ #category : #acccessing }
GtTitleWithCenteredTextsSlide >> newTextWithFormat: aRopedText [
	texts add: aRopedText asRopedText
]

{ #category : #accessing }
GtTitleWithCenteredTextsSlide >> subtitleBottomPadding [
	^ subtitleBottomPadding
]

{ #category : #accessing }
GtTitleWithCenteredTextsSlide >> subtitleBottomPadding: anObject [
	subtitleBottomPadding := anObject
]

{ #category : #accessing }
GtTitleWithCenteredTextsSlide >> textBottomPadding [
	^ textBottomPadding
]

{ #category : #accessing }
GtTitleWithCenteredTextsSlide >> textBottomPadding: anObject [
	textBottomPadding := anObject
]

{ #category : #acccessing }
GtTitleWithCenteredTextsSlide >> textMargin [
	^ textMargin
]

{ #category : #acccessing }
GtTitleWithCenteredTextsSlide >> textMargin: aNumber [
	textMargin := aNumber
]
