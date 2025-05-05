"
I am a scenery live slide. I take a scenery  defined in a method and display it in the middle of the screen.
Example: {{gtMethod:name=DemoSlideshow>>#scenery:|expanded}}


"
Class {
	#name : #GtSceneryLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'scenery'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSceneryLiveSlide >> create [
	^ scenery methodClass new perform: scenery selector
]

{ #category : #accessing }
GtSceneryLiveSlide >> scenery [
	^ scenery
]

{ #category : #accessing }
GtSceneryLiveSlide >> scenery: aCompiledMethod [
	scenery := aCompiledMethod
]
