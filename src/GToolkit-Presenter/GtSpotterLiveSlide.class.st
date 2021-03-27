"
I am a spotter live slide. I create a spotter element opened in the default context.

${method:GtExampleLiveShow>>#spotterExampleSlideFor:|expanded=}$
"
Class {
	#name : #GtSpotterLiveSlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSpotterLiveSlide >> create [
	| aSpotter aSpotterElement container |
	aSpotter := GtSpotter new.
	aSpotterElement := GtSpotterElement new.
	aSpotterElement spotterModel: aSpotter.
	aSpotterElement searchField requestFocus.
	aSpotterElement 	
		size: 600@400;
		aptitude: BrShadowAptitude;
		margin: (BlInsets all: 20).
	container := BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		layout: BlLinearLayout new alignCenter;
		addChild: aSpotterElement.
	^ container
]
