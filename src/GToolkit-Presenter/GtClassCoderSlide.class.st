Class {
	#name : #GtClassCoderSlide,
	#superclass : #GtSlide,
	#instVars : [
		'class',
		'methodExpanded',
		'headerExpanded'
	],
	#category : #'GToolkit-Presenter-GToolkit-Presenter'
}

{ #category : #accessing }
GtClassCoderSlide >> class: aClass [
	class := aClass
]

{ #category : #accessing }
GtClassCoderSlide >> create [
	| coder coderElement aScripter |
	
	coderElement := (GtPharoBehaviorCoder forClass: class) asElement.
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
	
	(self headerExpanded)
		ifTrue: [
			aScripter
				substep: 'Expand header'
				do: [ :aStep | 
					aStep click
						label: 'Expand coder header';
						onBreadthFirstChildOfClass: GtPharoBehaviorDefinitionCoderElement;
						onChildAt: 1.
					aStep wait forEmptySpaceTaskQueue ]].
	(self methodExpanded > 0)
		ifTrue: [
			aScripter
				substep: 'Expand method'
				do: [ :aStep | 
					aStep click
						label: 'Expand certain method in coder';
						onBreadthFirstChildOfClass: BrTabGroup;
						onChildAt: 2;
						onBreadthFirstChildOfClass: GtPharoMethodsCoderElement;
						onBreadthFirstChildOfClass: BrSimpleList;
						onBreadthFirstChildOfClass: BrInfiniteListElement;
						onChildAt: self methodExpanded;
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
		layout: BlLinearLayout horizontal;
		addChild: coderElement.
]

{ #category : #accessing }
GtClassCoderSlide >> headerExpanded [
	^ headerExpanded.
]

{ #category : #accessing }
GtClassCoderSlide >> headerExpanded: aBoolean [
	headerExpanded := aBoolean.
]

{ #category : #accessing }
GtClassCoderSlide >> initialize [
	super initialize.
	methodExpanded := 0.
	headerExpanded := false.
]

{ #category : #accessing }
GtClassCoderSlide >> methodExpanded [
	^ methodExpanded
]

{ #category : #accessing }
GtClassCoderSlide >> methodExpanded: aNumber [
	methodExpanded := aNumber.
]
