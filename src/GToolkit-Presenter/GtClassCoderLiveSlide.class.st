"
I am a class coder live slide. I create and display a coder opened on a given class. The coder can also have the header or a certain method expanded.

{{gtMethod:GtExampleLiveShow>>#classCoderExampleSlideFor:|expanded}}


"
Class {
	#name : #GtClassCoderLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'class',
		'expandHeader',
		'expandMethod'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtClassCoderLiveSlide >> class: aClass [
	class := aClass
]

{ #category : #'api - instantiation' }
GtClassCoderLiveSlide >> create [
	| coderElement aScripter |
	
	coderElement := (GtPharoBehaviorCoder forClass: class) asElement.
	coderElement
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets top: 5 right: 15 bottom: 5 left: 5).
		
	aScripter := BlScripter new.
	aScripter element: coderElement.
	
	self isHeaderExpanded
		ifTrue: [
			aScripter click
				label: 'Expand coder header';
				onBreadthFirstChildOfClass: GtPharoBehaviorDefinitionCoderElement;
				id: GtSourceCoderExpanderToggleId;
				play ].

	self expandedMethod > 0
		ifTrue: [
			aScripter click
				label: 'Expand certain method in coder';
				id: GtSourceCoderId index: self expandedMethod;
				play ].

	coderElement := aScripter elementWithoutParent.
	
	^ BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets all: 5);
		padding: (BlInsets all: 5);
		addChild: coderElement.
]

{ #category : #accessing }
GtClassCoderLiveSlide >> expandHeader: aBoolean [
	expandHeader := aBoolean.
]

{ #category : #accessing }
GtClassCoderLiveSlide >> expandMethodAt: aNumber [
	expandMethod := aNumber.
]

{ #category : #accessing }
GtClassCoderLiveSlide >> expandedMethod [
	^ expandMethod.
]

{ #category : #initialization }
GtClassCoderLiveSlide >> initialize [
	super initialize.
	expandMethod := 0.
	expandHeader := false.
]

{ #category : #accessing }
GtClassCoderLiveSlide >> isHeaderExpanded [
	^ expandHeader.
]
