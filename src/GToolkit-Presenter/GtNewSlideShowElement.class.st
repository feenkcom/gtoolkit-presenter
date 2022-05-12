Class {
	#name : #GtNewSlideShowElement,
	#superclass : #BlElement,
	#traits : 'TGtWithSlideShow + TBrLayoutResizable',
	#classTraits : 'TGtWithSlideShow classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'currentSlide',
		'slideElement',
		'previousSlideSwitch',
		'nextSlideSwitch',
		'menuButton'
	],
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #initialization }
GtNewSlideShowElement >> initialize [
	super initialize.
	
	self layout: BlLinearLayout horizontal.
	self matchParent.
	
	slideElement := GtNewSlideElement new.
	slideElement matchParent.
	
	previousSlideSwitch := self newPreviousSlideSwitch.
	previousSlideSwitch visibility: BlVisibility hidden.

	nextSlideSwitch := self newNextSlideSwitch.
	nextSlideSwitch visibility: BlVisibility hidden.
	
	menuButton := self newSlideShowDropdown.

	self addChildren: {
		previousSlideSwitch.
		slideElement.
		nextSlideSwitch.
		menuButton
	}.
	
	self when: BlClickEvent do: [ :anEvent | anEvent consumed: true. self requestFocus ].
	self addShortcut: (BlShortcutWithAction new
			combination: (BlKeyCombination arrowRight);
			action: [ self switchToNextSlide ]).
	self addShortcut: (BlShortcutWithAction new
			combination: (BlKeyCombination arrowLeft);
			action: [ self switchToPreviousSlide ]).
	
	previousSlideSwitch 
		when: BlClickEvent do: [ :e |
			e consumed: true.
			self switchToPreviousSlide ].
	
	nextSlideSwitch 
		when: BlClickEvent do: [ :e |
			e consumed: true.
			self switchToNextSlide ]
]

{ #category : #'private - instance creation' }
GtNewSlideShowElement >> newNextSlideArrow [
	^ BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beRight
]

{ #category : #'private - instance creation' }
GtNewSlideShowElement >> newNextSlideSwitch [
	^ self newSlideSwitch: (self newNextSlideArrow id: #nextSlideArrow)
]

{ #category : #'private - instance creation' }
GtNewSlideShowElement >> newPreviousSlideArrow [
	^ BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beLeft
]

{ #category : #'private - instance creation' }
GtNewSlideShowElement >> newPreviousSlideSwitch [
	^ self newSlideSwitch: (self newPreviousSlideArrow id: #previousSlideArrow)
]

{ #category : #'private - instance creation' }
GtNewSlideShowElement >> newSlideShowDropdown [
	^ BrButton new
		label: 'Slides';
		icon: BrGlamorousVectorIcons hamburger;
		aptitude: BrGlamorousButtonWithIconAptitude
			+ (BrGlamorousWithDropdownAptitude
				handle: [ 
					BrButton new
						aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
						icon: BrGlamorousVectorIcons hamburger;
						yourself ]
				content: [
					GtNewSlideShowPreviewElement new
						exact: 200@200;
						hFitContent;
						slideShow: slideShow ]);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored vertical alignBottom.
			c ignored horizontal alignRight.
			c margin: (BlInsets all: 10) ];
		yourself
]

{ #category : #'private - instance creation' }
GtNewSlideShowElement >> newSlideSwitch: aSwitchArrow [
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

{ #category : #'api - slide show' }
GtNewSlideShowElement >> onSlideShowChanged [
	"Is sent when a new slideShow is assigned to the receiver.
	Note: #onSlideShowChanged is sent before #subscribeToSlideShow
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideShowChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self switchToSlide: self slideShow slides first.
	self background: self slideShow background
]

{ #category : #'api - slide show' }
GtNewSlideShowElement >> preloadSlide: aSlide [
	self enqueueTask: (BlPromiseTask new promise: (aSlide slideArtifact await: (AsyncFutureExecutionConfiguration new customGroup: #Slides)))
]

{ #category : #'api - slide show' }
GtNewSlideShowElement >> switchToNextSlide [
	self slideShow
		slideAfter: currentSlide
		do: [ :aNextSlide | self switchToSlide: aNextSlide ]
]

{ #category : #'api - slide show' }
GtNewSlideShowElement >> switchToPreviousSlide [
	self slideShow
		slideBefore: currentSlide
		do: [ :aPreviousSlide | self switchToSlide: aPreviousSlide ]
]

{ #category : #'api - slide show' }
GtNewSlideShowElement >> switchToSlide: aSlide [
	currentSlide := aSlide.
	slideElement slide: aSlide.

	slideElement asyncFuture pendingPromise
		then: [
			slideShow slideAfter: currentSlide do: [ :aNextSlide | self preloadSlide: aNextSlide ].
			slideShow slideBefore: currentSlide do: [ :aPreviousSlide | self preloadSlide: aPreviousSlide ] ].
		
	(slideShow isFirstSlide: aSlide)
		ifTrue: [ previousSlideSwitch visibility: BlVisibility hidden ]
		ifFalse: [ previousSlideSwitch visibility: BlVisibility visible ].
		
	(slideShow isLastSlide: aSlide)
		ifTrue: [ nextSlideSwitch visibility: BlVisibility hidden ]
		ifFalse: [ nextSlideSwitch visibility: BlVisibility visible ]
]
