"
I am an element live slide. I get an element and display it in the middle of the screen.

{{gtMethod:GtExampleLiveShow>>#elementExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtElementLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtElementLiveSlide >> create [
	^ element value.
]

{ #category : #accessing }
GtElementLiveSlide >> element: anElementBlock [
	element := anElementBlock.
]
