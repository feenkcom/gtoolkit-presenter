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
		textContainer addChild: ((BrEditor new
				look: (BrGlamorousEditorLook new lineSpacing: 5);
				margin: (BlInsets top: 10 left: 10 bottom: 10 right: 20);
				hMatchParent;
				vFitContent;
				text: (texts inject: '' asRopedText into: [:each :all | all, String cr asRopedText, (each attributes: {BrTextParagraphMarginAttribute paragraphMargin: (BlInsets top: 20 left: 0 bottom: 20 right: 0)})]);
				beReadOnlyWithSelection) 
			asScalableElement maxScale: 1) .
	container 
		addChild: textContainer;
		addChild: (elementStencil value constraintsDo: [:c |
			c frame horizontal weight: elementWeight. 
			c frame horizontal alignRight.
			c vertical matchParent.
			c horizontal matchParent ]).
	container explainer isExplanationHolder: true.
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
	texts addFirst: aRopedText asRopedText
]
