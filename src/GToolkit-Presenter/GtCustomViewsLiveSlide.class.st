"
I show custom views for different objects.

{{gtMethod:GtExampleLiveShow>>#customViewsExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtCustomViewsLiveSlide,
	#superclass : #GtInspectorViewsLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtCustomViewsLiveSlide >> create [
	| container |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 3).
	{(21/2 gtPreviewFor: GtPhlowView empty) . 
	(FileLocator imageDirectory asFileReference gtItemsFor: GtPhlowView empty) . 
	((GtResourcesUtility resourceAtPath: (Path * 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png')) gtFigureFor: GtPhlowView empty) . 
	BlBezierElementExamples new curveWithAnchors gtLiveFor: GtPhlowView empty.
	(GtGraphCircleNeighbourhoodExamples new emptyNeighborhoodWithThreeCirclesAndSpace gtPreviewFor: GtPhlowView empty) . 
	(GtWhatMakesBlocSpecialExplanation new sampleText gtTextFor: GtPhlowView empty)} do: [:view | 
		container addChild: (( view
			asElementDo: [:e | 
				BlElement new 
					aptitude: BrShadowAptitude; 
					background: Color white;
					margin: (BlInsets all: 20);
					addChild: e]) size: 400@400) ].
	^ container asPannableElement
]
