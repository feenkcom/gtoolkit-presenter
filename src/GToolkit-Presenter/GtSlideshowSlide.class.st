Class {
	#name : #GtSlideshowSlide,
	#superclass : #GtSlide,
	#instVars : [
		'text',
		'slideshow',
		'title'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSlideshowSlide >> create [
	| mainContainer textContainer previewContainer |
	
	previewContainer := BlElement new
		layout: BlFlowLayout new;
		background: Color white;
		look: BrShadowLook;
		constraintsDo: [ :c |
			c linear horizontal alignCenter ];
		size: 500 @ 350;
		padding: (BlInsets all: 10);
		margin: (BlInsets top: 20 left: 5 bottom: 20 right: 5).
	
	previewContainer addChild: (slideshow value slides first create
		constraintsDo: [ :c | 
			c horizontal exact: 800.
			c vertical exact: 600 ];
		padding: (BlInsets all: 10)) asScalableElement.
	"slideshow value slides
		do: [ :each |
			previewContainer
				addChild: (each asPreviewElement) ]."
	
	previewContainer when: BlClickEvent do: [ :e | 
		GtHomeSection new showSpaceWithTitle: 'InspectorViews' with: slideshow value from: previewContainer ].
	
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
		layout: BlLinearLayout vertical.
	
	mainContainer addChild: textContainer.
	mainContainer addChild: previewContainer.
	
	^ mainContainer.
]

{ #category : #'as yet unclassified' }
GtSlideshowSlide >> initialize [
	super initialize.
	slideshow := [ GtSlideShow new ].
]

{ #category : #accessing }
GtSlideshowSlide >> slideshow: aSlideshow [
	self slideshow: aSlideshow withTitle: 'Slideshow'.
]

{ #category : #accessing }
GtSlideshowSlide >> slideshow: aSlideshow withTitle: aTitle [
	slideshow := aSlideshow.
	title := aTitle.
]

{ #category : #accessing }
GtSlideshowSlide >> text: aText [
	text := aText asRopedText glamorousRegularFont; fontSize: 16.
]

{ #category : #'as yet unclassified' }
GtSlideshowSlide >> textWithFormat: aText [
	text := aText asRopedText.
]
