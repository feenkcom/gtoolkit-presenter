"
I am a mash example live slide. I receive three elements and i show o mash of those three elements.

{{gtMethod:GtExampleLiveShow>>#mashExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtMashExampleLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'leftElement',
		'rightElement',
		'centerElement'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #accessing }
GtMashExampleLiveSlide >> centerElement: anElement [
	self centerElementWithConstraints: ( anElement
		constraintsDo: [:c |
			c frame horizontal alignCenter.
			c frame vertical alignBottom.
			c horizontal exact: 600.
			c vertical exact: 400];
		margin: (BlInsets all: 10)).
]

{ #category : #accessing }
GtMashExampleLiveSlide >> centerElementWithConstraints: anElement [
	centerElement := anElement.
]

{ #category : #'api - instantiation' }
GtMashExampleLiveSlide >> create [
	^ (BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 1200. 
			c vertical exact: 800. ];
		layout: BlFrameLayout new;
		addChildren: {leftElement. centerElement. rightElement}) asScalableElement.
]

{ #category : #initialization }
GtMashExampleLiveSlide >> initialize [
	super initialize.
	leftElement := BlElement new.
	centerElement := BlElement new.
	rightElement := BlElement new.
]

{ #category : #accessing }
GtMashExampleLiveSlide >> leftElement: anElement [
	self leftElementWithConstraints: (anElement
		constraintsDo: [:c |
			c frame horizontal alignLeft. 
			c frame vertical alignTop.
			c horizontal exact: 600.
			c vertical exact: 400];
		margin: (BlInsets top: 100 right: 10 bottom: 10 left: 10)).
]

{ #category : #accessing }
GtMashExampleLiveSlide >> leftElementWithConstraints: anElement [
	leftElement := anElement.
]

{ #category : #accessing }
GtMashExampleLiveSlide >> rightElement: anElement [
	self rightElementWithConstraints: (anElement
		constraintsDo: [:c |
			c frame horizontal alignRight. 
			c frame vertical alignTop.
			c horizontal exact: 600.
			c vertical exact: 400];
		margin: (BlInsets all: 10)).
]

{ #category : #accessing }
GtMashExampleLiveSlide >> rightElementWithConstraints: anElement [
	rightElement := anElement.
]
