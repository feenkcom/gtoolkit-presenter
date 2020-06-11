Class {
	#name : #GtClassCoderSlide,
	#superclass : #GtSlide,
	#instVars : [
		'class'
	],
	#category : #'GToolkit-Presenter-GToolkit-Presenter'
}

{ #category : #accessing }
GtClassCoderSlide >> class: aClass [
	class := aClass
]

{ #category : #accessing }
GtClassCoderSlide >> create [
	| container coder coderElement inspectorElement inspectorContainer |
	
	container := BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets all: 5);
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal.
	
	coder := GtClassCoder forClass: class.
	coderElement := coder asElement.
	coderElement
		forceLayout;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets top: 5 right: 15 bottom: 5 left: 5).
	
	inspectorContainer := BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets top: 5 right: 5 bottom: 5 left: 15);
		layout: BlLinearLayout horizontal;
		background: Color white;
		look: BrShadowLook.
	
	
	^ container
		addChild: coderElement.
]
