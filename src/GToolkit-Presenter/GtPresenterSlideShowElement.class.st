Class {
	#name : #GtPresenterSlideShowElement,
	#superclass : #BlElement,
	#traits : 'TGtPresenterWithSlideShowViewModel + TBrLayoutResizable',
	#classTraits : 'TGtPresenterWithSlideShowViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'slideElement',
		'previousSlideSwitch',
		'nextSlideSwitch',
		'menuButton'
	],
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #initialization }
GtPresenterSlideShowElement >> initialize [
	super initialize.
	
	self layout: BlLinearLayout horizontal.
	self matchParent.
	self beFocusable.
	
	slideElement := GtPresenterSlideElement new.
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
GtPresenterSlideShowElement >> newNextSlideArrow [
	^ BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beRight
]

{ #category : #'private - instance creation' }
GtPresenterSlideShowElement >> newNextSlideSwitch [
	^ self newSlideSwitch: (self newNextSlideArrow id: #nextSlideArrow)
]

{ #category : #'private - instance creation' }
GtPresenterSlideShowElement >> newPreviousSlideArrow [
	^ BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beLeft
]

{ #category : #'private - instance creation' }
GtPresenterSlideShowElement >> newPreviousSlideSwitch [
	^ self newSlideSwitch: (self newPreviousSlideArrow id: #previousSlideArrow)
]

{ #category : #'private - instance creation' }
GtPresenterSlideShowElement >> newSlideShowDropdown [
	^ BrButton new
		label: 'Slides';
		icon: BrGlamorousVectorIcons hamburger;
		aptitude: BrGlamorousButtonWithIconAptitude
			+ (BrGlamorousWithExplicitDropdownAptitude
				handle: [ 
					BrButton new
						aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
						icon: BrGlamorousVectorIcons hamburger;
						yourself ]
				content: [
					GtPresenterSlideShowPreviewElement new
						exact: 200@200;
						hFitContent;
						slideShowViewModel: slideShowViewModel ]);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored vertical alignBottom.
			c ignored horizontal alignRight.
			c margin: (BlInsets all: 10) ];
		yourself
]

{ #category : #'private - instance creation' }
GtPresenterSlideShowElement >> newSlideSwitch: aSwitchArrow [
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

{ #category : #'private - event handling' }
GtPresenterSlideShowElement >> onCurrentSlideChanged: anAnnouncement [
	self switchToSlide: anAnnouncement currentSlide
]

{ #category : #'api - slide show view model' }
GtPresenterSlideShowElement >> onSlideShowViewModelChanged [
	"Is sent when a new slideShowViewModel is assigned to the receiver.
	Note: #onSlideShowViewModelChanged is sent before #subscribeToSlideShowViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideShowViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self switchToSlide: slideShowViewModel currentSlide
]

{ #category : #'api - slide show view model' }
GtPresenterSlideShowElement >> preloadSlide: aSlideViewModel [
	self enqueueTask: (BlPromiseTask new promise: (aSlideViewModel slideArtifact await: (AsyncFutureExecutionConfiguration new customGroup: #Slides)))
]

{ #category : #'api - slide show view model' }
GtPresenterSlideShowElement >> subscribeToSlideShowViewModel [
	"Is sent after a new slideShowViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlideShowViewModel if the receiver subscribes to them"
	<modelSubscriber: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	slideShowViewModel
		when: GtPresenterSlideShowViewModelCurrentSlideChanged
		send: #onCurrentSlideChanged:
		to: self
]

{ #category : #'api - slide show view model' }
GtPresenterSlideShowElement >> switchToNextSlide [
	slideShowViewModel switchToNextSlide
]

{ #category : #'api - slide show view model' }
GtPresenterSlideShowElement >> switchToPreviousSlide [
	slideShowViewModel switchToPreviousSlide
]

{ #category : #'api - slide show view model' }
GtPresenterSlideShowElement >> switchToSlide: aSlideViewModel [
	slideElement slideViewModel: aSlideViewModel.

	slideElement asyncFuture pendingPromise
		then: [
			slideShowViewModel slideAfter: aSlideViewModel do: [ :aNextSlideViewModel | self preloadSlide: aNextSlideViewModel ].
			slideShowViewModel slideBefore: aSlideViewModel do: [ :aPreviousSlideViewModel | self preloadSlide: aPreviousSlideViewModel ] ].
		
	(slideShowViewModel isFirstSlide: aSlideViewModel)
		ifTrue: [ previousSlideSwitch visibility: BlVisibility hidden ]
		ifFalse: [ previousSlideSwitch visibility: BlVisibility visible ].
		
	(slideShowViewModel isLastSlide: aSlideViewModel)
		ifTrue: [ nextSlideSwitch visibility: BlVisibility hidden ]
		ifFalse: [ nextSlideSwitch visibility: BlVisibility visible ]
]

{ #category : #'api - slide show view model' }
GtPresenterSlideShowElement >> unsubscribeFromSlideShowViewModel [
	"Is sent before a new slideShowViewModel is assigned to the receiver.
	Objects that subscribe to slideShowViewModel are required to implement this method."
	<modelUnsubscriber: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	slideShowViewModel unsubscribe: self
]
