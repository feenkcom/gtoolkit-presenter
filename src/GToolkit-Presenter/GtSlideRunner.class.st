Class {
	#name : #GtSlideRunner,
	#superclass : #Object,
	#instVars : [
		'slide'
	],
	#category : 'GToolkit-Presenter-Runtime'
}

{ #category : #accessing }
GtSlideRunner >> run [
	| space |
	BlUseAsyncFeatures disableDuring:[
		| slideElement |
		slideElement := slide asElement.
		space := BlSpace new.
		space host: BlMockedHost new.
		space extent: 800@600.
		space addChild: slideElement.
		slide performActionOn: slideElement.
		space pulse.
	].
	^ space
]

{ #category : #accessing }
GtSlideRunner >> slide: aSlide [
	slide := aSlide.
]
