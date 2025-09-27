Class {
	#name : #GtLiveShowElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'slideShow',
		'slideElement',
		'slidesContainer',
		'slideEditorVisibility',
		'slideEditorResizer',
		'slideEditor',
		'slideEditorHeightStrategy'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'private - instance creation' }
GtLiveShowElement >> buildSlideshowContainerComponents [
	| previousElement nextElement aToolbar |
	
	slideElement := BrHorizontalPane new matchParent.
	
	previousElement := self newPreviousSlideSwitch.
	nextElement := self newNextSlideSwitch.
	
	slidesContainer := slidesContainer := BrHorizontalPane new
		matchParent;
		addAptitude: (BrGlamorousWithMaximizerAptitude new hideMaximizeButton preferredBackground: Color white);
		addChildren: { previousElement . slideElement . nextElement }.
	
	slideEditorVisibility := false.
	slideEditor := BrFrame new
		matchParent;
		addAptitude: BrShadowAptitude + (BrGlamorousWithVerticalResizerAptitude new beTop
				resizerDo: [ :theResizer | slideEditorResizer := theResizer ]);
		background: self background;
		margin: (BlInsets top: 5 right: 30 bottom: 5 left: 30).
	slideEditorResizer
		when: BlResizerResizedEvent
		do: [:anEvent |
			slideEditorHeightStrategy := BrResizerElementLength exact: anEvent extent y.
			slideEditorHeightStrategy adjustHeightFor: slideEditor ].
	
	aToolbar := BrToolbar new
		constraintsDo: [:c |
			c frame horizontal alignRight.
			c frame vertical alignTop ];
		margin: (BlInsets top: 10 right: 5 bottom: 5 left: 5);		
		aptitude: BrGlamorousToolbarAptitude;
		addItem:
			(BrButton new
				beNormalSize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				label: 'Add new slide' asString;
				icon: BrGlamorousVectorIcons add asElement;
				action: [ self createNewEmptySlide ]).
	
	slideEditor addChild: aToolbar.
	
	self slidesDropdown.
]

{ #category : #initialization }
GtLiveShowElement >> initialize [
	super initialize.
	
	self matchParent
]

{ #category : #'private - instance creation' }
GtLiveShowElement >> newNextSlideArrow [
	^ BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beRight
]

{ #category : #'private - instance creation' }
GtLiveShowElement >> newNextSlideSwitch [
	^ (self newSlideSwitch: (self newNextSlideArrow id: #nextSlideArrow))
		when: BlClickEvent do: [ :e |
			e consumed: true.
			self switchToNextSlide ]
]

{ #category : #'private - instance creation' }
GtLiveShowElement >> newPreviousSlideArrow [
	^ BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beLeft
]

{ #category : #'private - instance creation' }
GtLiveShowElement >> newPreviousSlideSwitch [
	^ (self newSlideSwitch: (self newPreviousSlideArrow id: #previousSlideArrow))
		when: BlClickEvent do: [ :e |
			e consumed: true.
			self switchToPreviousSlide ]
]

{ #category : #'private - instance creation' }
GtLiveShowElement >> newSlideSwitch: aSwitchArrow [
	^ BrHorizontalPane new
		hExact: 24;
		vMatchParent;
		alignCenter;
		addChild: aSwitchArrow;
		addAptitude: (BrStyleCommonAptitude new
			/ aSwitchArrow id;
			default: [ :aStyle | aStyle background: (BrGlamorousColors defaultButtonBorderColor) ];
			hovered: [ :aStyle | aStyle background: (BrGlamorousColors hoveredButtonBorderColor) ])
]

{ #category : #'hooks - children' }
GtLiveShowElement >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self slideShow onAddedToSceneGraph: self space
]

{ #category : #accessing }
GtLiveShowElement >> slideShow [
	^ slideShow
]

{ #category : #accessing }
GtLiveShowElement >> slideShow: anObject [
	slideShow := anObject
]

{ #category : #'api - slide control' }
GtLiveShowElement >> switchToNextSlide [
]

{ #category : #'api - slide control' }
GtLiveShowElement >> switchToPreviousSlide [
]
