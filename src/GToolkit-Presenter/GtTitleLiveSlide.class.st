"
I am a title live slide. I get a text for the title and, if necessary, a text for the subtitle.

{{gtMethod:GtExampleLiveShow>>#titleExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtTitleLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'subtitle',
		'title',
		'titleBottomPadding'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtTitleLiveSlide >> create [
	^  BlElement new 
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout horizontal;
				addChild: (
					BlElement new
						constraintsDo: [ :c |
							c horizontal matchParent.
							c vertical fitContent.
							c linear vertical alignCenter ];
						layout: BlLinearLayout vertical;
						addChild: (BlTextElement new 
							constraintsDo: [ :c |
								c linear horizontal alignCenter ];
							padding: (BlInsets top: 40; bottom: self titleBottomPadding);
							text: title);
						addChild: (BlTextElement new 
							constraintsDo: [ :c |
								c linear horizontal alignCenter ];
							text: subtitle))
]

{ #category : #initialization }
GtTitleLiveSlide >> defaultTitleBottomPadding [
	^ 30
]

{ #category : #initialization }
GtTitleLiveSlide >> initialize [
	super initialize.
	self title: ''.
	self subtitle: ''.
	self titleBottomPadding: self defaultTitleBottomPadding
]

{ #category : #accessing }
GtTitleLiveSlide >> subtitle: aString [
	self subtitleWithFormat: (aString asRopedText fontSize: 20; glamorousRegularFont).
]

{ #category : #accessing }
GtTitleLiveSlide >> subtitleWithFormat: aText [
	subtitle := aText
]

{ #category : #accessing }
GtTitleLiveSlide >> title: aString [
	self titleWithFormat: (aString asRopedText fontSize: 30; glamorousRegularFont).
]

{ #category : #'api - instantiation' }
GtTitleLiveSlide >> titleBottomPadding [
	^ titleBottomPadding
]

{ #category : #initialization }
GtTitleLiveSlide >> titleBottomPadding: anInteger [
	"The default padding of 10 can be too tight."
	titleBottomPadding := anInteger
]

{ #category : #accessing }
GtTitleLiveSlide >> titleWithFormat: aString [
	title := aString.
]
