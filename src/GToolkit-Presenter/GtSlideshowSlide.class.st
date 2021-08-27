Class {
	#name : 'GtSlideshowSlide',
	#superclass : 'GtSlide',
	#instVars : [
		'text',
		'slideshow',
		'title'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtSlideshowSlide >> create [
	| mainContainer textContainer previewContainer previewHeader previewContent |
	
	previewHeader := BlElement new
		constraintsDo: [:c | c horizontal matchParent. c vertical fitContent ];
		layout: BlLinearLayout vertical;
		background: BrGlamorousColors defaultButtonBorderColor;
		addChild: (BrLabel new aptitude: (BrGlamorousLabelAptitude new fontSize: 15);
		text: 'Slideshow').
	
	previewContent := (slideshow value slides first create
		constraintsDo: [ :c | 
			c horizontal exact: 800.
			c vertical exact: 600 ];
		padding: (BlInsets all: 10)) asScalableElement.
	
	previewContainer := BrButton new
		size: 500 @ 350;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | c linear horizontal alignCenter ];
		aptitude: BrGlamorousButtonExteriorAptitude new;
		padding: (BlInsets all: 1);
		margin: (BlInsets top: 10 left: 20 bottom: 10 right: 20);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		action: [ :card |
			| aSpace |
			aSpace := BlSpace new.
			aSpace title: title.
			aSpace extent: 1200@600.
			aSpace addChild: slideshow value makeArrowsVisible asElement.
			aSpace withHalos.
			card showSpace: aSpace ].
	
	textContainer := BlTextElement new
		constraintsDo: [:c |
			c linear horizontal alignCenter ];
		layout: BlLinearLayout vertical alignCenter;
		padding: (BlInsets all: 5);
		margin: (BlInsets top: 10 left: 5 bottom: 10 right: 5);
		text: text.
	
	mainContainer := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout vertical alignCenter.
		
	previewContainer
		addChild: (previewHeader preventMeAndChildrenMouseEvents);
		addChild: (previewContent preventMeAndChildrenMouseEvents).
	
	^ mainContainer
			addChild: textContainer;
			addChild: previewContainer.
]

{ #category : 'as yet unclassified' }
GtSlideshowSlide >> initialize [
	super initialize.
	slideshow := [ GtSlideShow new ].
]

{ #category : 'accessing' }
GtSlideshowSlide >> slideshow: aSlideshow [
	self slideshow: aSlideshow withTitle: 'Slideshow'.
]

{ #category : 'accessing' }
GtSlideshowSlide >> slideshow: aSlideshow withTitle: aTitle [
	slideshow := aSlideshow.
	title := aTitle.
]

{ #category : 'accessing' }
GtSlideshowSlide >> text: aText [
	text := aText asRopedText glamorousRegularFont; fontSize: 16.
]

{ #category : 'as yet unclassified' }
GtSlideshowSlide >> textWithFormat: aText [
	text := aText asRopedText.
]
