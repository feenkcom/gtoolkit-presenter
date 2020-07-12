Class {
	#name : #GtTextSlide,
	#superclass : #GtSlide,
	#instVars : [
		'texts'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtTextSlide >> create [
	| container textContainer |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets top: 20 bottom: 20);
		layout: BlFrameLayout new.
	textContainer := BlElement new
		constraintsDo: [:c |
			c frame horizontal weight: 0.6.
			c vertical matchParent.
			c horizontal matchParent ];
		layout: BlLinearLayout vertical alignCenter.
	texts do: [ :aText |
		textContainer addChild: (BrEditor new
				look: (BrGlamorousEditorLook new lineSpacing: 5);
				margin: (BlInsets all: 50);
				hMatchParent;
				vFitContent;
				text: aText;
				beReadOnlyWithSelection)].
	container addChild: textContainer.
	^ container
]

{ #category : #initialization }
GtTextSlide >> initialize [
	super initialize.
	texts := OrderedCollection new
]

{ #category : #'api - instantiation' }
GtTextSlide >> newText: aRopedText [
	self newTextWithFormat: (aRopedText asRopedText glamorousRegularFont; fontSize: 20)
]

{ #category : #'api - instantiation' }
GtTextSlide >> newTextWithFormat: aRopedText [
	texts add: aRopedText asRopedText
]
