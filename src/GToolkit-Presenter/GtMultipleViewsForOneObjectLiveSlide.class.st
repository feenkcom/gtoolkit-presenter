"
I show different visualizations for the same object.

{{gtMethod:GtExampleLiveShow>>#multipleViewsForOneObjectExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtMultipleViewsForOneObjectLiveSlide,
	#superclass : #GtInspectorViewsLiveSlide,
	#instVars : [
		'containerLayout'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtMultipleViewsForOneObjectLiveSlide >> create [
	| container object |
	object := GtWhatMakesBlocSpecialExplanation new sampleText.
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: containerLayout.
	{
		(object gtTextFor: GtPhlowView empty) . 
		(object gtTextAttributesFor: GtPhlowView empty) . 
		(object gtStringFor: GtPhlowView empty).
		(object gtStoreStringFor: GtPhlowView empty)} do: [:view | 
		container addChild: (( view
			asElementDo: [:e | 
				BlElement new 		
					constraintsDo: [:c |
						c horizontal fitContent.
						c vertical fitContent ];		
					layout: BlLinearLayout vertical alignCenter;
					addChild: (BrLabel new text: view title; aptitude: (BrGlamorousLabelAptitude new foreground: Color gray));
					addChild: (
						BlElement new 
							aptitude: BrShadowAptitude; 
							constraintsDo: [:c |
								c horizontal exact: 400.
								c vertical exact: 400 ];	
							background: Color white;
							margin: (BlInsets all: 20);
							addChild: e)])) ].
	^ container asPannableElement
]

{ #category : #accessing }
GtMultipleViewsForOneObjectLiveSlide >> grid [
	containerLayout := BlGridLayout new columnCount: 2; cellSpacing: 10
]

{ #category : #initialization }
GtMultipleViewsForOneObjectLiveSlide >> initialize [
	super initialize.
	containerLayout := BlLinearLayout horizontal
]

{ #category : #accessing }
GtMultipleViewsForOneObjectLiveSlide >> vertical [
	containerLayout := BlLinearLayout vertical
]
