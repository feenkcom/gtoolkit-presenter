Class {
	#name : #GtMashExampleSlide,
	#superclass : #GtSlide,
	#instVars : [
		'elements'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtMashExampleSlide >> centerElement: anElement [
	self centerElementWithConstraints: ( anElement
		constraintsDo: [:c |
			c frame horizontal alignCenter.
			c frame vertical alignBottom.
			c horizontal exact: 600.
			c vertical exact: 400];
		margin: (BlInsets all: 10)).
]

{ #category : #accessing }
GtMashExampleSlide >> centerElementWithConstraints: anElement [
	elements add: anElement.
]

{ #category : #accessing }
GtMashExampleSlide >> create [
	^ (BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 1200. 
			c vertical exact: 800. ];
		layout: BlFrameLayout new;
		addChildren: elements) asScalableElement.
]

{ #category : #accessing }
GtMashExampleSlide >> initialize [
	super initialize.
	elements := OrderedCollection new.
]

{ #category : #accessing }
GtMashExampleSlide >> leftElement: anElement [
	self leftElementWithConstraints: (anElement
		constraintsDo: [:c |
			c frame horizontal alignLeft. 
			c frame vertical alignTop.
			c horizontal exact: 600.
			c vertical exact: 400];
		margin: (BlInsets top: 100 right: 10 bottom: 10 left: 10)).
]

{ #category : #accessing }
GtMashExampleSlide >> leftElementWithConstraints: anElement [
	elements add: anElement.
]

{ #category : #accessing }
GtMashExampleSlide >> rightElement: anElement [
	self rightElementWithConstraints: (anElement
		constraintsDo: [:c |
			c frame horizontal alignRight. 
			c frame vertical alignTop.
			c horizontal exact: 600.
			c vertical exact: 400];
		margin: (BlInsets all: 10)).
]

{ #category : #accessing }
GtMashExampleSlide >> rightElementWithConstraints: anElement [
	elements add: anElement.
]
