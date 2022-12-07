"
I am a spotter live slide. I create a spotter element opened in the default context.

{{gtMethod:GtExampleLiveShow>>#spotterExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtSpotterLiveSlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSpotterLiveSlide >> create [
	| aSpotter aSpotterElement container |
	aSpotter := GtSpotter on: GtWorldSpotterSearchStart new.
	aSpotterElement := GtStreamingSpotterElement new.
	aSpotterElement spotter: aSpotter.
"	aSpotterElement searchField requestFocus."
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
