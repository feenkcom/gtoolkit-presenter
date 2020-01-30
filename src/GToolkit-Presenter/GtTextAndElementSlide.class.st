Class {
	#name : #GtTextAndElementSlide,
	#superclass : #GtSlide,
	#instVars : [
		'texts',
		'elementStencil',
		'elementWeight'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtTextAndElementSlide >> create [
	| container textContainer |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets top: 20 bottom: 20);
		layout: BlFrameLayout new.
	textContainer := BlElement new
		constraintsDo: [:c |
			c frame horizontal weight: (1 - elementWeight). 
			c vertical matchParent.
			c horizontal matchParent ];
		layout: BlLinearLayout vertical alignCenter.
	texts do: [ :aText |
		textContainer addChild: (BrEditor new
				look: (BrGlamorousEditorLook new lineSpacing: 3);
				margin: (BlInsets all: 10);
				hMatchParent;
				vFitContent;
				text: aText )].
	container 
		addChild: textContainer;
		addChild: (elementStencil value constraintsDo: [:c |
			c frame horizontal weight: elementWeight. 
			c frame horizontal alignRight.
			c vertical matchParent.
			c horizontal matchParent ]).
	^ container
]

{ #category : #'api - instantiation' }
GtTextAndElementSlide >> element: aStencil [
	elementStencil := aStencil
]

{ #category : #'api - instantiation' }
GtTextAndElementSlide >> elementWeight: aNumber [
	elementWeight := aNumber
]

{ #category : #initialization }
GtTextAndElementSlide >> initialize [
	super initialize.
	texts := OrderedCollection new.
	elementStencil := [ BlElement new ].
	elementWeight := 0.5
]

{ #category : #'api - instantiation' }
GtTextAndElementSlide >> newText: aRopedText [
	self newTextWithFormat: (aRopedText asRopedText fontSize: 16)
]

{ #category : #'api - instantiation' }
GtTextAndElementSlide >> newTextWithFormat: aRopedText [
	texts add: aRopedText asRopedText
]
