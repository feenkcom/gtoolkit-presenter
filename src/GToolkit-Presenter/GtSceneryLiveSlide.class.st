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
	| container sceneryElement |
	container := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout vertical;
			margin: (BlInsets all: 20);
			yourself.
	sceneryElement := (GtPagerSettings usedPager
			createWrappedOn: self sceneryStencil) maximized.
	container
		addChild: (sceneryElement
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ]).
	^ container
]

{ #category : #accessing }
GtSceneryLiveSlide >> scenery [
	^ scenery
]

{ #category : #accessing }
GtSceneryLiveSlide >> scenery: aCompiledMethod [
	scenery := aCompiledMethod
]

{ #category : #accessing }
GtSceneryLiveSlide >> sceneryStencil [
	^ scenery methodClass new perform: scenery selector
]
