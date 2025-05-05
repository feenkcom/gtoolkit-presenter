"
I am a lable and element live slide. I get a label in the form of a text and an element. The element is displayed in the center and the label is positioned on top.

{{gtMethod:GtExampleLiveShow>>#labelAndElementSlideFor:|expanded=}}


"
Class {
	#name : #GtLabelAndElementLiveSlide,
	#superclass : #GtLabelAndEntityLiveSlide,
	#instVars : [
		'elementBlock'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtLabelAndElementLiveSlide >> create [
	| container |
	container := super create.
	container
		addChild: (BlElement new
				constraintsDo: [ :ct | 
					ct vertical matchParent.
					ct horizontal matchParent ];
				layout: BlLinearLayout vertical;
				margin: (BlInsets all: 20);
				addChild: (elementBlock value asElement
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ])).
	^ container
]

{ #category : #accessing }
GtLabelAndElementLiveSlide >> element: anElement [
	elementBlock := anElement.
]

{ #category : #initialization }
GtLabelAndElementLiveSlide >> initialize [
	super initialize.
	self element: BlElement new
]
