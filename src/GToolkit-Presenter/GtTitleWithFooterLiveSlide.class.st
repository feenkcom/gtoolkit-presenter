Class {
	#name : #GtTitleWithFooterLiveSlide,
	#superclass : #GtTitleLiveSlide,
	#instVars : [
		'footer',
		'subtitleBottomPadding'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtTitleWithFooterLiveSlide >> create [
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		addChild: (BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent.
					c linear vertical alignCenter ];
				layout: BlLinearLayout vertical;
				addChild: (BlTextElement new
						constraintsDo: [ :c | c linear horizontal alignCenter ];
						padding: (BlInsets
								top: 40;
								bottom: self titleBottomPadding);
						text: title);
				addChild: (BlTextElement new
						constraintsDo: [ :c | c linear horizontal alignCenter ];
						padding: (BlInsets
								top: 40;
								bottom: self subtitleBottomPadding);
						text: subtitle);
				addChild: (BlTextElement new
						constraintsDo: [ :c | c linear horizontal alignCenter ];
						text: footer))
]

{ #category : #accessing }
GtTitleWithFooterLiveSlide >> footer: aString [
	self
		footerWithFormat: (aString asRopedText
				fontSize: 20;
				glamorousRegularFont)
]

{ #category : #accessing }
GtTitleWithFooterLiveSlide >> footerWithFormat: aText [
	footer := aText
]

{ #category : #initialization }
GtTitleWithFooterLiveSlide >> initialize [
	super initialize.
	self subtitleBottomPadding: 10
]

{ #category : #'api - instantiation' }
GtTitleWithFooterLiveSlide >> subtitleBottomPadding [
	^ subtitleBottomPadding
]

{ #category : #accessing }
GtTitleWithFooterLiveSlide >> subtitleBottomPadding: anInteger [
	subtitleBottomPadding := anInteger
]
