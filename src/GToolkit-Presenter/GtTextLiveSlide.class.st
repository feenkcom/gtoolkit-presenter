"
I am a text live slide. I receive a text, with or without a format and display it on the screen.

{{gtMethod:GtExampleLiveShow>>#textExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtTextLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'texts'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtTextLiveSlide >> create [
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
				aptitude: (BrGlamorousEditorAptitude new lineSpacing: 5);
				margin: (BlInsets all: 50);
				hMatchParent;
				vFitContent;
				text: aText;
				beReadOnlyWithSelection)].
	container addChild: textContainer.
	^ container
]

{ #category : #initialization }
GtTextLiveSlide >> initialize [
	super initialize.
	texts := OrderedCollection new
]

{ #category : #accessing }
GtTextLiveSlide >> newText: aRopedText [
	self newTextWithFormat: (aRopedText asRopedText glamorousRegularFont; fontSize: 20)
]

{ #category : #accessing }
GtTextLiveSlide >> newTextWithFormat: aRopedText [
	texts add: aRopedText asRopedText
]
