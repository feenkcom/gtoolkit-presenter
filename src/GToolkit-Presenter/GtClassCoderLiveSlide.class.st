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
		'expandMethods'
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
		margin: (BlInsets
				top: 5
				right: 15
				bottom: 5
				left: 5).

	aScripter := BlScripter new.
	aScripter element: coderElement.

	self isHeaderExpanded
		ifTrue: [ aScripter click
				label: 'Expand coder header';
				onBreadthFirstChildOfClass: GtPharoBehaviorDefinitionCoderElement;
				id: GtSourceCoderExpanderToggleId;
				play ].

	self expandedMethods
		do: [ :anIndex | 
			aScripter do
				action: [ | methodsCoderViewModel method |
					methodsCoderViewModel := coderElement streamingMethodCodersElement
							streamingCodersViewModel.
					method := methodsCoderViewModel streamingCodersModel itemsStream toArray
							wait at: anIndex.
					methodsCoderViewModel scrollToCompiledMethod: method ];
				play.
			aScripter click
				label: 'Expand certain method in coder';
				// (GtSourceCoderId indexed: anIndex);
				play ].

	coderElement := aScripter elementWithoutParent.

	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets all: 5);
		padding: (BlInsets all: 5);
		addChild: coderElement
]

{ #category : #accessing }
GtClassCoderLiveSlide >> expandHeader: aBoolean [
	expandHeader := aBoolean.
]

{ #category : #accessing }
GtClassCoderLiveSlide >> expandMethodAt: aNumber [
	expandMethods add: aNumber
]

{ #category : #accessing }
GtClassCoderLiveSlide >> expandedMethods [
	^ expandMethods.
]

{ #category : #initialization }
GtClassCoderLiveSlide >> initialize [
	super initialize.
	expandMethods := OrderedCollection new.
	expandHeader := false.
]

{ #category : #accessing }
GtClassCoderLiveSlide >> isHeaderExpanded [
	^ expandHeader.
]
