Class {
	#name : #GtPresenterCanvasSlide,
	#superclass : #BlElement,
	#instVars : [
		'slideContainer',
		'toolbar',
		'slide'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtPresenterCanvasSlide class >> for: aSlide [ 
	^ self new slide: aSlide
]

{ #category : #accessing }
GtPresenterCanvasSlide >> addSlideElement: aSlide [
	| slideViewModel |
	slideViewModel := GtPresenterSlideViewModel new slide: aSlide.
	self addChild: (GtPresenterSlideElement new slideViewModel: slideViewModel)
]

{ #category : #'as yet unclassified' }
GtPresenterCanvasSlide >> initialize [
	super initialize.
	self layout: (BlLinearLayout vertical cellSpacing: 5).
	toolbar := BrToolbar new
			aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
			fitContent;
			addChild: (BrButton new
					beTinySize;
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons refresh;
					label: 'Refresh slide';
					action: [ :aButton :aModel :anEvent | 
						self children last removeFromParent.
						self
							addChild: (GtPresenterSlideElement new
									slideViewModel: (GtPresenterSlideViewModel new slide: slide)) ]);
			addChild: (BrButton new
					beTinySize;
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect slide';
					action: [ :aButton :aModel :anEvent | aButton phlow spawnObject: slide ]).
	self
		addEventHandler: BlPullHandler new;
		size: 300 @ 200;
		background: Color white;
		aptitude: BrShadowAptitude new + BrGlamorousWithVerticalResizerAptitude new
				+ BrGlamorousWithHorizontalResizerAptitude new;
		addChild: toolbar.
]

{ #category : #accessing }
GtPresenterCanvasSlide >> slide: aSlide [
	slide := aSlide.
	self addSlideElement: aSlide
]

{ #category : #accessing }
GtPresenterCanvasSlide >> updateSlide [
	self children last removeFromParent.
	self addSlideElement: slide
]
