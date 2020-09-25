Class {
	#name : #GtRawViewsLiveSlide,
	#superclass : #GtInspectorViewsLiveSlide,
	#instVars : [
		'containerLayout'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtRawViewsLiveSlide >> create [
	| container |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 3).
	{21/2 . 
	FileLocator imageDirectory asFileReference.
	GtResourcesUtility resourceAtPath: (Path * 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png'). 
	BlBezierElementExamples new curveWithAnchors.
	GtGraphCircleNeighbourhoodExamples new emptyNeighborhoodWithThreeCirclesAndSpace .
	GtWhatMakesBlocSpecialExplanation new sampleText} do: [:x | 
		container addChild: (((x gtRawFor: GtPhlowView empty) 
			asElementDo: [:e | 
				BlElement new 
					look: BrShadowLook; 
					background: Color white;
					margin: (BlInsets all: 20);
					addChild: e]) size: 400@400) ].
	^ container asPannableElement
]
