"
I am a class coder live slide. I create and display a coder opened on a given class. The coder can also have the header or a certain method expanded.

${method:GtExampleLiveShow>>#classCoderExampleSlideFor:|expanded}$
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
	| coder coderElement aScripter |
	
	coderElement := (GtClassCoder forClass: class) asElement.
	coderElement
		forceLayout;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets top: 5 right: 15 bottom: 5 left: 5).
		
	aScripter := BlDevScripter new.
	aScripter
		substep: 'Coder Element'
		do: [ :aStep | 
			aStep set
				label: 'Coder';
				element: [ coderElement ] ].
	
	(self isHeaderExpanded)
		ifTrue: [
			aScripter
				substep: 'Expand header'
				do: [ :aStep | 
					aStep click
						label: 'Expand coder header';
						onBreadthFirstChildOfClass: GtBehaviorCoderHeaderElement;
						onChildAt: 1.
					aStep wait forEmptySpaceTaskQueue ]].
	(self expandedMethod > 0)
		ifTrue: [
			aScripter
				substep: 'Expand method'
				do: [ :aStep | 
					aStep click
						label: 'Expand certain method in coder';
						onBreadthFirstChildOfClass: BrTabGroup;
						onChildAt: 2;
						onBreadthFirstChildOfClass: GtCodersElement;
						onBreadthFirstChildOfClass: BrSimpleList;
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: self expandedMethod;
						onChildAt: 1.
					aStep wait forEmptySpaceTaskQueue ]].
	aScripter syncContinue.
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
