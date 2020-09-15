Class {
	#name : #GtTextAndElementLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'elementWeight',
		'elementStencil',
		'texts'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtTextAndElementLiveSlide >> create [
	| container textContainer completeText |
	completeText := texts allButFirst 
		inject: (texts first asRopedText attributes: {
				BrTextParagraphMarginAttribute 
					paragraphMargin: (BlInsets top: 10 left: 0 bottom: 0 right: 0)}) 
		into: [:all :each | 
			all, String cr asRopedText, 
			(each attributes: {
				BrTextParagraphMarginAttribute 
					paragraphMargin: (BlInsets top: 10 left: 0 bottom: 0 right: 0)})].
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
		padding: (BlInsets top: 10 left: 50 bottom: 10 right: 50);
		layout: BlLinearLayout vertical alignCenter.
		textContainer addChild: ((BrEditor new
				look: (BrGlamorousEditorLook new lineSpacing: 5);
				hMatchParent;
				vFitContent;
				text: completeText)
				beReadOnlyWithSelection
				asScalableElement maxScale: 1).
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

{ #category : #accessing }
GtTextAndElementLiveSlide >> element: aStencil [
	elementStencil := aStencil
]

{ #category : #accessing }
GtTextAndElementLiveSlide >> elementWeight: aNumber [
	elementWeight := aNumber
]

{ #category : #accessing }
GtTextAndElementLiveSlide >> initialize [
	super initialize.
	texts := OrderedCollection new.
	elementStencil := [ BlElement new ].
	elementWeight := 0.5
]

{ #category : #accessing }
GtTextAndElementLiveSlide >> newText: aRopedText [
	self newTextWithFormat: (aRopedText asRopedText glamorousRegularFont; fontSize: 20)
]

{ #category : #accessing }
GtTextAndElementLiveSlide >> newTextWithFormat: aRopedText [
	texts add: aRopedText asRopedText
]
