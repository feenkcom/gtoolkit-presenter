Class {
	#name : #GtMultipleViewsForOneObjectSlide,
	#superclass : #GtInspectorViewsSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtMultipleViewsForOneObjectSlide >> create [
	| container object |
	object := GtWhatMakesBlocSpecialExplanation new sampleText.
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: BlLinearLayout horizontal.
	{
		(object gtTextFor: GtPhlowView empty) . 
		(object gtTreeFor: GtPhlowView empty) . 
		(object gtStringFor: GtPhlowView empty).
		(object gtStoreStringFor: GtPhlowView empty)} do: [:view | 
		container addChild: (( view
			asElementDo: [:e | 
				BlElement new 		
					constraintsDo: [:c |
						c horizontal fitContent.
						c vertical fitContent ];		
					layout: BlLinearLayout vertical alignCenter;
					addChild: (BrLabel new text: view title; look: (BrGlamorousLabelLook new foreground: Color gray));
					addChild: (
						BlElement new 
							look: BrShadowLook; 
							constraintsDo: [:c |
								c horizontal exact: 400.
								c vertical exact: 400 ];	
							background: Color white;
							margin: (BlInsets all: 20);
							addChild: e)])) ].
	^ container asPannableElement
]
