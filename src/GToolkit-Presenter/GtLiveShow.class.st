"
I am responsible for creating a liveshow. A liveshow is a slideshow that can be edited live. It has a collection of slides. Slides can be changed, removed and added to the collection live, during the presentation.
"
Class {
	#name : #GtLiveShow,
	#superclass : #BrStencil,
	#instVars : [
		'dropdown',
		'previewsContainer',
		'background',
		'title',
		'arrowsAreVisible',
		'previousArrow',
		'nextArrow',
		'slideElement',
		'slidesContainer',
		'currentSlide',
		'slides',
		'coderElement',
		'coderElementHeightStrategy',
		'coderElementResizer',
		'extraSlidesAdded',
		'coderElementVisibility'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtLiveShow >> addSlide: aSlide [
	self slides add: aSlide.
]

{ #category : #accessing }
GtLiveShow >> background [
	^ background.
]

{ #category : #accessing }
GtLiveShow >> background: anObject [
	background := anObject.
]

{ #category : #accessing }
GtLiveShow >> buildSlideshowContainerComponents [
	| previousElement nextElement |
	
	slideElement := BlElement new
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal.
		
	previousElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 24. c vertical matchParent ];
		when: BlClickEvent do: [:e | self previousStep ];
		layout: BlLinearLayout new alignCenter.
	previousArrow := BrButton new
		size: 12 @ 24;
		when: BlClickEvent do: [:e | self previousStep ];
		geometry:
			(BlPolygon
				vertices:
					{(12 @ 0).
					(0 @ 12).
					(12 @ 24)});
		look: (BrInteractiveCommonLook new
				default: [ :aWidget | aWidget background: (BrGlamorousColors defaultButtonBorderColor) ];
				hovered: [ :aWidget | aWidget background: (BrGlamorousColors hoveredButtonBorderColor) ]);
		background: BrGlamorousColors defaultButtonBorderColor.
	previousElement addChild: previousArrow.
	
	nextElement := BlElement new 
		constraintsDo: [:c | c horizontal exact: 24. c vertical matchParent ];
		when: BlClickEvent do: [:e | self nextStep ];
		layout: BlLinearLayout new alignCenter.
	nextArrow := BrButton new
		size: 12 @ 24;
		when: BlClickEvent do: [:e | self nextStep ];
		geometry:
			(BlPolygon
				vertices:
					{(0 @ 0).
					(12 @ 12).
					(0 @ 24)});
		look: (BrInteractiveCommonLook new
				default: [ :aWidget | aWidget background: (BrGlamorousColors defaultButtonBorderColor) ];
				hovered: [ :aWidget | aWidget background: (BrGlamorousColors hoveredButtonBorderColor) ]);
		background: BrGlamorousColors defaultButtonBorderColor.
	nextElement addChild: nextArrow.
	
	slidesContainer := BlElement new 
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ];
		layout: BlLinearLayout horizontal;
		addChild: previousElement;
		addChild: slideElement;
		addChild: nextElement.
	
	coderElementVisibility := false.
	coderElement := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent];
		look: BrShadowLook + 
			(BrGlamorousWithVerticalResizerLook new beTop
				resizerDo: [ :theResizer | coderElementResizer := theResizer ]);
		background: self background;
		margin: (BlInsets top: 5 right: 30 bottom: 5 left: 30).
	coderElementResizer
		when: BlResizerResizedEvent
		do: [:anEvent |
			coderElementHeightStrategy := BrResizerElementLength exact: anEvent extent y.
			coderElementHeightStrategy adjustHeightFor: coderElement ].
	
	self slidesDropdown.
]

{ #category : #accessing }
GtLiveShow >> coderElement [
	^ coderElement.
]

{ #category : #accessing }
GtLiveShow >> collectSlides [
	| theSlides |
	theSlides := GtSlidesCollector new
		object: self;
		from: self class;
		to: self class;
		collect.
	self slides: theSlides.
]

{ #category : #'api - instantiation' }
GtLiveShow >> create [
	| previousElement nextElement container |

	container := GtSlideShowElement new slideShow: self.
	container 
		background: self background;
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent];
		layout: BlLinearLayout vertical.
	
	container addChild: slidesContainer.
	container addChild: self coderElement.
	container addChild: self dropdown.
	self updateCoderElementState.
	
	container addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowRight build;
		action: [ self nextStep ]).
	container addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowLeft build;
		action: [ self previousStep ]).
	^ container
]

{ #category : #accessing }
GtLiveShow >> createNewEmptySlide [
	| priority |
	(self slides isNotEmpty)
		ifTrue: [ priority := ((self slides at: self currentSlideIndex) priority + 1) asString ]
		ifFalse: [ priority := 1 asString ].
	extraSlidesAdded := extraSlidesAdded + 1.

	self class
		compile: ('slide', extraSlidesAdded asString, 'For: aSlide
	<gtSlide>
	"Rename this method to be more representative for your slide"
	^ aSlide empty
		priority: ', priority, '.')
		classified: ''.
]

{ #category : #accessing }
GtLiveShow >> currentSlideIndex [
	"Answer the index of the currently displayed slide.
	nil if the slides aren't yet displayed"

	^currentSlide
		ifNil: [ nil ] 
		ifNotNil: [ currentSlide slideIndex ]
]

{ #category : #accessing }
GtLiveShow >> dropdown [
	^ dropdown.
]

{ #category : #accessing }
GtLiveShow >> enqueueTask: aTask [

	slidesContainer enqueueTask: aTask
]

{ #category : #accessing }
GtLiveShow >> exportSlides [
	self slides
		withIndexDo: [ :eachSlide :anIndex |	
			| eachCachedElement eachSlideElement |		

			eachCachedElement := eachSlide asCachedElement.
			eachSlideElement := eachCachedElement slideElement
				ifNil: [ eachCachedElement ].
			eachSlideElement asSpartaForm
				writePNGFileNamed: self title, ' - ', anIndex asString, '.png' ]
]

{ #category : #accessing }
GtLiveShow >> gtSlidesFor: aView [
	<gtView>
	^ aView list
		title: 'Slides';
		items: [ self slides ];
		itemText: #name
]

{ #category : #accessing }
GtLiveShow >> hasNextSlide [
	^ self slides last ~= currentSlide
]

{ #category : #accessing }
GtLiveShow >> hasPreviousSlide [
	^ self slides first ~= currentSlide
]

{ #category : #initialization }
GtLiveShow >> initialize [
	super initialize.
	slides := OrderedCollection new.
	arrowsAreVisible := false.
	background := Color white.
	extraSlidesAdded := 0.
	self buildSlideshowContainerComponents.
	self unsubscribeFromSystem.
	self subscribeToSystem.
	self initializeSlides.
]

{ #category : #accessing }
GtLiveShow >> initializeSlides [
	self collectSlides.
	(self slides size = 0)
		ifTrue: [ self createNewEmptySlide ]
		ifFalse: [
			self slides withIndexDo: [ :slide :index | 
				slide 
					slideShow: self;
					slideIndex: index ].
			self showSlide: self slides first.
			self updateCoderElementMethod.
			self updatePreviewsContainer ].
]

{ #category : #accessing }
GtLiveShow >> makeArrowsVisible [
	arrowsAreVisible := true
]

{ #category : #accessing }
GtLiveShow >> makeCoderElementVisible [
	coderElementVisibility := true.
]

{ #category : #accessing }
GtLiveShow >> nextStep [
	self hasNextSlide ifFalse: [ ^ self ].
	currentSlide nextStepWith: self.
	self updateCoderElementMethod.
]

{ #category : #'private - event handling' }
GtLiveShow >> onAddedToSceneGraph: aSpace [
	"If my element has been added to a scene graph ensure the slides have been generated"

	self slides withIndexDo: [ :eachSlide :eachIndex |
		aSpace telemetry
			timeSync: [ 'Queue slide {1} to async update' format: { eachIndex } ]
			during: [ eachSlide queueAsyncUpdate: aSpace ] ]
]

{ #category : #accessing }
GtLiveShow >> onMethodAdded: aMethodAdded [
	(aMethodAdded method hasPragmaNamed: #gtSlide) ifFalse: [ ^ self ].
	(GtSystemUtility 
		isClass: self class
		sameOrSubclassOf: aMethodAdded classAffected) ifFalse: [ ^ self ].
	self slides detect: [:aSlide | aSlide definingMethod = aMethodAdded method] ifFound: [^ self ].
	self slideDefinitionAddedFor: aMethodAdded.
]

{ #category : #accessing }
GtLiveShow >> previousStep [
	self hasPreviousSlide ifFalse: [ ^ self ].
	currentSlide previousStepWith: self.
	self updateCoderElementMethod.
]

{ #category : #'api - updating' }
GtLiveShow >> replaceSlide: aSlide with: aNewSlide [ 
	self slides indexOf: aSlide ifAbsent: [ ^ self ].
	self slides add: aNewSlide after: aSlide.
	self slides remove: aSlide.
	
	aNewSlide
		slideShow: self;
		slideIndex: aSlide slideIndex.
			
	slideElement 
		removeChildren;
		addChild: aNewSlide asElement
]

{ #category : #accessing }
GtLiveShow >> showSlide: aSlide [
	| slideContentElement |
	currentSlide = aSlide
		ifTrue: [ ^ self ].
	slideContentElement := aSlide asCachedElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	currentSlide := aSlide.
	self updateArrows.
]

{ #category : #accessing }
GtLiveShow >> showSlideAfter: aSlide [
	self showSlide: (self slides at: currentSlide slideIndex + 1)
]

{ #category : #accessing }
GtLiveShow >> showSlideBefore: aSlide [
	self showSlide: (self slides at: currentSlide slideIndex - 1)
]

{ #category : #'api - updating' }
GtLiveShow >> slideDefinitionAddedFor: aMethod [
	"I am called when a new method has been added.
	Subclasses may react to the method being added.
	I may be called from a non-UI process."
	<gtCollector>
	| aNewSlide |
	aNewSlide := self 
		perform: aMethod selector
		with: GtEmptySlide new.
	self addSlide: aNewSlide.
	self sortSlidesByPriority.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
	self showSlide: aNewSlide.
	coderElementVisibility := true.
	self updateCoderElementMethod.
	self updateCoderElementState.
	self updatePreviewsContainer.
]

{ #category : #'api - updating' }
GtLiveShow >> slideDefinitionChangedFor: aSlide [
	"I am called from aSlide when the slide definition has changed.
	My responsibility is to replace the slide with a new one."
	<gtCollector>
	| aNewSlide currentIndex |
	aNewSlide := self 
		perform: aSlide definingMethod selector
		with: GtEmptySlide new.
	currentIndex := self currentSlideIndex.
	
	self replaceSlide: aSlide with: aNewSlide.
	self sortSlidesByPriority.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
	self showSlide: (self slides at: currentIndex).
	self updateCoderElementMethod.
	self updatePreviewsContainer.
]

{ #category : #'api - updating' }
GtLiveShow >> slideDefinitionRemovedFor: aSlide [
	"I am called from aSlide when the slide definition has been removed.
	My responsibility is to remove the slide from the show."
	self slides remove: aSlide ifAbsent: [ ^ self ].
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
	(self slides isNotEmpty)
		ifTrue: [
			(aSlide slideIndex = 1)
				ifTrue: [
					self showSlide: self slides first.
					self updateCoderElementMethod ]
				ifFalse: [
					self showSlide: (self slides at: (aSlide slideIndex - 1)).
					self updateCoderElementMethod ].
			self updatePreviewsContainer ]
		ifFalse: [ self createNewEmptySlide ].
]

{ #category : #accessing }
GtLiveShow >> slides [
	^ slides
]

{ #category : #accessing }
GtLiveShow >> slides: anObject [
	slides := anObject
]

{ #category : #accessing }
GtLiveShow >> slidesContainer [

	^slidesContainer
]

{ #category : #accessing }
GtLiveShow >> slidesDropdown [
	| aToolbar |
	previewsContainer := BlElement new.
	previewsContainer
		layout: BlFlowLayout new;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ];
		padding: (BlInsets all: 10).
	self updatePreviewsContainer.
	^ dropdown := BrButton new
		constraintsDo: [:c |
			c frame horizontal alignRight.
			c frame vertical alignCenter];
		margin: (BlInsets all: 10);
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Slides';
		look: 
			BrGlamorousButtonWithIconLook
			+ (BrGlamorousWithDropdownLook
				handle: [ BrButton new
						look: BrGlamorousButtonWithIconLook 
							- BrGlamorousButtonWithLabelTooltipLook
							- BrGlamorousButtonExteriorLook;
						icon: BrGlamorousIcons hamburger asElement;
						yourself ]
				content: [ | el |
					aToolbar := BrToolbar new.
					aToolbar look: BrGlamorousToolbarLook.
					aToolbar
						addItem:
							(BrToggle new
								beSmall;
								look: BrGlamorousButtonWithIconLook + BrGlamorousToggleBackgroundLook;
								icon: BrGlamorousIcons edit asElement;
								label: 'Update arrows' asString;
								when: BrToggleActivatedEvent
									do: [ :anEvent | 
									arrowsAreVisible := true.
									self updateArrows ];
								when: BrToggleDeactivatedEvent
									do: [ :anEvent | 
									arrowsAreVisible := false.
									self updateArrows ]);
						addItem:
							(BrToggle new
								beSmall;
								look: BrGlamorousButtonWithIconLook + BrGlamorousToggleBackgroundLook;
								icon: BrGlamorousIcons browse asElement;
								label: 'Browse slide method' asString;
								when: BrToggleActivatedEvent
									do: [ :anEvent | 
										coderElementVisibility := coderElementVisibility not.
										self updateCoderElementState ];
								when: BrToggleDeactivatedEvent
									do: [ :anEvent | 
										coderElementVisibility := coderElementVisibility not.
										self updateCoderElementState ]);
						addItem:
							(BrButton new
								beSmall;
								look: BrGlamorousButtonWithIconLook;
								label: 'Export slides' asString;
								icon: BrGlamorousIcons save asElement;
								action: [ self exportSlides ]);
						addItem:
							(BrButton new
								beSmall;
								look: BrGlamorousButtonWithIconLook;
								label: 'Add new slide' asString;
								icon: BrGlamorousIcons add asElement;
								action: [
									self createNewEmptySlide.
									"We simulate a click on the dropdown button to close it so we can update the previews container 
									inside, after the method is compiled and the new slide is added."
									BlSpace simulateClickOn: self dropdown ]).
					el := BlElement new
						size: 700 @ 520;
						layout: BlLinearLayout vertical;
						addChild: previewsContainer asScrollableElement;
						addChild: aToolbar.
					el ]);
			constraintsDo: [ :c | c linear horizontal alignRight ];
			padding: (BlInsets all: 10);
			yourself.
]

{ #category : #accessing }
GtLiveShow >> sortSlidesByPriority [
	self slides sort: [:a :b | a priority < b priority].
]

{ #category : #'private - subscriptions' }
GtLiveShow >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #onMethodAdded: to: self.
]

{ #category : #accessing }
GtLiveShow >> title [
	^ title ifNil: [ 'Gt Slide Show' ]
]

{ #category : #accessing }
GtLiveShow >> title: anObject [
	title := anObject.
]

{ #category : #'private - subscriptions' }
GtLiveShow >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self.
]

{ #category : #'api - updating' }
GtLiveShow >> updateArrows [
	(arrowsAreVisible and: [ self hasPreviousSlide ])
		ifTrue: [ previousArrow visibility: BlVisibility visible ]
		ifFalse: [ previousArrow visibility: BlVisibility hidden ].
	(arrowsAreVisible and: [ self hasNextSlide ])
		ifTrue: [ nextArrow visibility: BlVisibility visible ]
		ifFalse: [ nextArrow visibility: BlVisibility hidden ]
]

{ #category : #'api - updating' }
GtLiveShow >> updateCoderElementMethod [
	| methodCoder |
	(coderElement children size > 1) ifTrue: [coderElement removeChildAt: 2].
	methodCoder := (GtMethodCoder new 
			forMethod: (self slides at: self currentSlideIndex) definingMethod;
			expanded: true;
			asElement)
				vMatchParent;
				hMatchParent;
				margin: (BlInsets top: 5 right: 10 bottom: 5 left: 10).
	coderElement
		addChild: (
			(GtPager createWrappedOn: methodCoder)
				maximized
				background: BrGlamorousColors neutralBackgroundColor).
]

{ #category : #'api - updating' }
GtLiveShow >> updateCoderElementState [
	coderElementVisibility
		ifTrue: [
			coderElement visibility: BlVisibility visible]
		ifFalse: [
			coderElement visibility: BlVisibility gone].
]

{ #category : #'api - updating' }
GtLiveShow >> updatePreviewsContainer [
	previewsContainer removeChildren.
	self slides
		do: [ :each | 
			previewsContainer
				addChild:
					(each asPreviewElement
						when: BlClickEvent
						do: [ :e | 
							self showSlide: each.
							self updateCoderElementMethod ]) ].
]

{ #category : #'api - updating' }
GtLiveShow >> updateSlide: aSlide [
	| slideContentElement |
	currentSlide = aSlide ifFalse: [ ^ self ].
	slideContentElement := aSlide asCachedElement.
	slideElement removeChildren.
	slideElement addChild: slideContentElement.
	self updateArrows.
]
