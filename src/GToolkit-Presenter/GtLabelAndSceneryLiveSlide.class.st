"
I am a label and scenery live slide. I get a scenery as a method. The element is displayed in the center and the label is positioned on top.

Example: {{gtMethod:name=DemoSlideshow>>#sceneryWithLabel:|expanded}} 


"
Class {
	#name : #GtLabelAndSceneryLiveSlide,
	#superclass : #GtLabelAndEntityLiveSlide,
	#instVars : [
		'scenery'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtLabelAndSceneryLiveSlide >> create [
	| container sceneryElement |
	container := super create.
	sceneryElement := (scenery methodClass new perform: scenery selector) asElement.
	container
		addChild: (BlElement new
				constraintsDo: [ :ct | 
					ct vertical matchParent.
					ct horizontal matchParent ];
				layout: BlLinearLayout vertical;
				margin: (BlInsets all: 20);
				addChild: (sceneryElement
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ])).
	^ container
]

{ #category : #accessing }
GtLabelAndSceneryLiveSlide >> scenery [
	^ scenery
]

{ #category : #accessing }
GtLabelAndSceneryLiveSlide >> scenery: aCompiledMethod [
	scenery := aCompiledMethod
]
