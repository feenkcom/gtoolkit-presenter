"
Like a title slide but with as many centred texts below as you like.
"
Class {
	#name : #GtTitleWithFootersLiveSlide,
	#superclass : #GtTitleLiveSlide,
	#instVars : [
		'subtitleBottomPadding',
		'footers',
		'footerBottomPadding'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtTitleWithFootersLiveSlide >> create [
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
	footers
		do: [ :aText | 
			textContainer
				addChild: (BlTextElement new
						constraintsDo: [ :c | c linear horizontal alignCenter ];
						padding: (BlInsets
								top: 40;
								bottom: self footerBottomPadding);
						text: aText) ].
	container addChild: textContainer.
	^ container
]

{ #category : #initialization }
GtTitleWithFootersLiveSlide >> defaultFooterBottomPadding [
	^ 10
]

{ #category : #initialization }
GtTitleWithFootersLiveSlide >> defaultSubtitleBottomPadding [
	^ 40
]

{ #category : #accessing }
GtTitleWithFootersLiveSlide >> footerBottomPadding [
	^ footerBottomPadding
]

{ #category : #accessing }
GtTitleWithFootersLiveSlide >> footerBottomPadding: anObject [
	footerBottomPadding := anObject
]

{ #category : #initialization }
GtTitleWithFootersLiveSlide >> initialize [
	super initialize.
	self subtitleBottomPadding: self defaultSubtitleBottomPadding.
	self footerBottomPadding: self defaultFooterBottomPadding.
	footers := OrderedCollection new
]

{ #category : #acccessing }
GtTitleWithFootersLiveSlide >> newFooter: aRopedText [
	self
		newFooterWithFormat: (aRopedText asRopedText
				glamorousRegularFont;
				fontSize: 20)
]

{ #category : #acccessing }
GtTitleWithFootersLiveSlide >> newFooterWithFormat: aRopedText [
	footers add: aRopedText asRopedText
]

{ #category : #acccessing }
GtTitleWithFootersLiveSlide >> newText: aRopedText [
	self deprecated: 'use newFooter:'.
	
	self newTextWithFormat: (aRopedText asRopedText glamorousRegularFont; fontSize: 20)
]

{ #category : #acccessing }
GtTitleWithFootersLiveSlide >> newTextWithFormat: aRopedText [
self deprecated: 'use newFooterWithFormat:'.
	footers add: aRopedText asRopedText
]

{ #category : #accessing }
GtTitleWithFootersLiveSlide >> subtitleBottomPadding [
	^ subtitleBottomPadding
]

{ #category : #accessing }
GtTitleWithFootersLiveSlide >> subtitleBottomPadding: anObject [
	subtitleBottomPadding := anObject
]
