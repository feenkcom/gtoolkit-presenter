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
		'extraSlidesAdded',
		'slideEditorVisibility',
		'slideEditorResizer',
		'slideEditorHeightStrategy',
		'slideEditor',
		'targetLiveShow',
		'pager'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtLiveShow class >> create: aLiveShowObject [
	^ self new
		targetLiveShow: aLiveShowObject;
		initializeSubscriptions;
		initializeSlides.
]

{ #category : #accessing }
GtLiveShow class >> createInEditMode: aLiveShowObject [
	^ self new
		targetLiveShow: aLiveShowObject;
		initializeSubscriptions;
		initializeSlides;
		makeSlideEditorVisible.
]

{ #category : #accessing }
GtLiveShow class >> createWithArrowsVisible: aLiveShowObject [
	^ self new
		targetLiveShow: aLiveShowObject;
		initializeSubscriptions;
		initializeSlides;
		makeArrowsVisible.
]

{ #category : #accessing }
GtLiveShow class >> createWithArrowsVisibleInEditMode: aLiveShowObject [
	^ self new
		targetLiveShow: aLiveShowObject;
		initializeSubscriptions;
		initializeSlides;
		makeArrowsVisible;
		makeSlideEditorVisible.
]

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
	| previousElement nextElement aToolbar |
	
	slideElement := BrHorizontalPane new matchParent.
		
	previousArrow := BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beLeft.
	previousElement := BrHorizontalPane new
		hExact: 24;
		vMatchParent;
		alignCenter;
		when: BlClickEvent do: [:e | self previousStep ];
		addChild: previousArrow;
		addAptitude: (BrStyleCommonAptitude new
			@ previousArrow;
			default: [ :aStyle | aStyle background: (BrGlamorousColors defaultButtonBorderColor) ];
			hovered: [ :aStyle | aStyle background: (BrGlamorousColors hoveredButtonBorderColor) ]).
	
	nextArrow := BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beRight.
	nextElement := BrHorizontalPane new
		hExact: 24;
		vMatchParent;
		alignCenter;
		when: BlClickEvent do: [:e | self nextStep ];
		addChild: nextArrow;
		addAptitude: (BrStyleCommonAptitude new
			@ nextArrow;
			default: [ :aStyle | aStyle background: (BrGlamorousColors defaultButtonBorderColor) ];
			hovered: [ :aStyle | aStyle background: (BrGlamorousColors hoveredButtonBorderColor) ]).
	
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
				icon: BrGlamorousIcons add asElement;
				action: [ self createNewEmptySlide ]).
	
	slideEditor addChild: aToolbar.
	
	self slidesDropdown.
]

{ #category : #accessing }
GtLiveShow >> collectSlides [
	| theSlides |
	theSlides := GtSlidesCollector new
		object: self targetLiveShow;
		from: self targetLiveShow class;
		to: self targetLiveShow class;
		collect.
	self slides: theSlides.
]

{ #category : #'api - instantiation' }
GtLiveShow >> create [
	| container |

	container := GtSlideShowElement new slideShow: self.
	container 
		background: self background;
		constraintsDo: [:c | c horizontal matchParent. c vertical matchParent];
		layout: BlLinearLayout vertical.
	
	container addChild: slidesContainer.
	container addChild: self slideEditor.
	container addChild: self dropdown.
	self updateSlideEditorState.
	
	container addShortcut: (BlShortcutWithAction new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowRight build;
		action: [ self nextStep ]).
	container addShortcut: (BlShortcutWithAction new
		repeatable: false;
		combination: BlKeyCombination builder alt arrowLeft build;
		action: [ self previousStep ]).
	^ container
]

{ #category : #accessing }
GtLiveShow >> createNewEmptySlide [
	| priority stopPosition |
	(self slides isNotEmpty)
		ifTrue: [
			priority := ((self slides at: self currentSlideIndex) priority + 1) asString.
			stopPosition := self slides size.
			(self slides size) to: (self currentSlideIndex + 1) by: -1 do: [:index |
				((((self slides at: index) priority) - ((self slides at: (index - 1)) priority)) > 1)
					ifTrue: [ stopPosition := index - 1 ]].
			stopPosition to: (self currentSlideIndex + 1) by: -1 do: [:index |
				self updateMethodForSlide: (self slides at: index)]]
		ifFalse: [ 
			priority := 1 asString ].
	extraSlidesAdded := extraSlidesAdded + 1.

	self targetLiveShow class
		compile: ('slide', extraSlidesAdded asString, 'For: aSlide
	<gtSlide>
	"Rename this method to be more representative for your slide"
	^ aSlide empty
		priority: ', priority, '.')
		classified: 'slides'.
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
GtLiveShow >> dropdownExportStencilFor [
	| dropdownLook selectionElement |

	^ selectionElement := BrSlideImageExport new
		folder: FileLocator home;
		fileFilterBlock: [ :file | (file extension asLowercase = 'jpeg') or: [file extension asLowercase = 'png'] ];
		okAction: [ :folder :fileName | 
			self
				export: selectionElement exportRange
				as: selectionElement imageFormat
				withSize: ((selectionElement imageWidth asNumber) @ (selectionElement imageHeight asNumber))
				andFileName: fileName
				in: ((folder / fileName) ensureCreateDirectory)];
		buttonLabel: 'Export';
		padding: (BlInsets all: 20);
		constraintsDo: [:c |
			c vertical matchParent.
			c horizontal matchParent].
]

{ #category : #accessing }
GtLiveShow >> enqueueTask: aTask [

	slidesContainer enqueueTask: aTask
]

{ #category : #accessing }
GtLiveShow >> export: anExportQuantity as: aFormat withSize: aSize andFileName: aFileName in: aFolder [
	(anExportQuantity asLowercase = 'all')
		ifTrue: [
			self 
				exportAllSlidesAs: aFormat 
				withSize: aSize 
				andFileName: aFileName 
				in: aFolder ].
	(anExportQuantity asLowercase = 'current')
		ifTrue: [
			self 
				exportSlide: currentSlide 
				as: aFormat 
				withSize: aSize 
				andFileName: aFileName 
				in: aFolder ].
	
	slideElement removeChildren.
	slideElement addChild: currentSlide asCachedElement.
	
	self generateVideoScriptIn: aFolder. 
]

{ #category : #accessing }
GtLiveShow >> exportAllSlidesAs: aFormat withSize: aSize andFileName: aFileName in: aFolder [
	self slides do: [:eachSlide |
		self exportSlide: eachSlide as: aFormat withSize: aSize andFileName: aFileName in: aFolder ].
]

{ #category : #accessing }
GtLiveShow >> exportSlide: aSlide as: aFormat withSize: aSize andFileName: aFileName in: aFolder [
	| container cachedElement fileName |
	container := BlElement new.
	container width: aSize x.
	container height: aSize y.
	
	cachedElement := aSlide asCachedElement.
	container addChild: cachedElement removeFromParent.
	(aFormat asUppercase = 'JPEG' or: [aFormat asUppercase = 'JPG'])
		ifTrue: [
			fileName := aFileName, ' - ', aSlide slideIndex asString, '.jpg'.
			BlExporter jpg
				element: container;
				background: Color white;
   			 fileName: aFolder / fileName;
   			 scaled: 1;
   			 export ]
		ifFalse: [
			fileName := aFileName, ' - ', aSlide slideIndex asString, '.png'.
			BlExporter png
				element: container;
				background: Color transparent;
  			  fileName: aFolder / fileName;
   			 scaled: 1;
   			 export ].
	container removeChildren.
]

{ #category : #accessing }
GtLiveShow >> generateVideoScriptIn: aFolder [
	| textFileContent textFileName |
	
	textFileContent := '---
voice: rodney
size: 1080p
canvas: white
transition: crossfade 0.3' asString.
	
	self slides
		withIndexDo: [ :eachSlide :anIndex |	
			textFileContent := textFileContent,'

---

![contain](' asString, self title, ' - ', anIndex asString, '.jpeg)

' asString.
	
			(eachSlide notes isNil)
				ifTrue: [ textFileContent := textFileContent, '(pause: 1)' asString ]
				ifFalse: [ textFileContent := textFileContent, eachSlide notes asString ] ].

	textFileName := self title asString, '.txt'.
	(aFolder / textFileName) asFileReference
		writeStreamDo: [:s | s nextPutAll: textFileContent].
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
	extraSlidesAdded ifNil: [ extraSlidesAdded := 0 ].
	pager := BrPager new matchParent.
	self buildSlideshowContainerComponents.
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
			self updateSlideEditorMethod.
			self updatePreviewsContainer.
			self updateSlidePreviewsLook ].
]

{ #category : #accessing }
GtLiveShow >> initializeSubscriptions [
	self unsubscribeFromSystem.
	self subscribeToSystem.
]

{ #category : #accessing }
GtLiveShow >> makeArrowsVisible [
	arrowsAreVisible := true
]

{ #category : #accessing }
GtLiveShow >> makeSlideEditorVisible [
	slideEditorVisibility := true.
]

{ #category : #accessing }
GtLiveShow >> nextStep [
	self hasNextSlide ifFalse: [ ^ self ].
	currentSlide nextStepWith: self.
	self updateSlideEditorMethod.
	self updateSlidePreviewsLook.
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
	(aMethodAdded classAffected = self targetLiveShow class) ifFalse: [ ^ self ].	
	self slides detect: [:aSlide | aSlide definingMethod = aMethodAdded method] ifFound: [^ self ].
	self slideDefinitionAddedFor: aMethodAdded.
]

{ #category : #accessing }
GtLiveShow >> pager [
	^ pager.
]

{ #category : #accessing }
GtLiveShow >> previousStep [
	self hasPreviousSlide ifFalse: [ ^ self ].
	currentSlide previousStepWith: self.
	self updateSlideEditorMethod.
	self updateSlidePreviewsLook.
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
	aNewSlide := self targetLiveShow
		perform: aMethod selector
		with: GtEmptySlide new.
	self addSlide: aNewSlide.
	self sortSlidesByPriority.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
	self showSlide: aNewSlide.
	slideEditorVisibility := true.
	self updateSlideEditorMethod.
	self updateSlideEditorState.
	self updatePreviewsContainer.
]

{ #category : #'api - updating' }
GtLiveShow >> slideDefinitionChangedFor: aSlide [
	"I am called from aSlide when the slide definition has changed.
	My responsibility is to replace the slide with a new one."
	<gtCollector>
	| aNewSlide |
	aNewSlide := self targetLiveShow
		perform: aSlide definingMethod selector
		with: GtEmptySlide new.
	
	self slides remove: aSlide ifAbsent: [ ^ self ].
	self addSlide: aNewSlide.
	self sortSlidesByPriority.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideShow: self;
			slideIndex: index ].
	self showSlide: aNewSlide.
	self updateSlideEditorMethod.
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
					self updateSlideEditorMethod ]
				ifFalse: [
					self showSlide: (self slides at: (aSlide slideIndex - 1)).
					self updateSlideEditorMethod ].
			self updatePreviewsContainer ]
		ifFalse: [	
			previousArrow visibility: BlVisibility hidden.
			nextArrow visibility: BlVisibility hidden.
			(slideEditor children size = 3)
				ifTrue: [ slideEditor removeChildAt: 3 ].
			slideElement addChild: (BlElement new
				background: BlBackground transparent;
				constraintsDo: [:c |
					c vertical matchParent.
					c horizontal matchParent]).
			self updatePreviewsContainer ].
]

{ #category : #accessing }
GtLiveShow >> slideEditor [
	^ slideEditor.
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
	| aToolbar anExportButton |
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
		aptitude: 
			BrGlamorousButtonWithIconAptitude
			+ (BrGlamorousWithDropdownAptitude
				handle: [ BrButton new
						aptitude: BrGlamorousButtonWithIconAptitude 
							- BrGlamorousButtonWithLabelTooltipAptitude
							- BrGlamorousButtonExteriorAptitude;
						icon: BrGlamorousIcons hamburger asElement;
						yourself ]
				content: [ | el |
					aToolbar := BrToolbar new.
					aToolbar aptitude: BrGlamorousToolbarAptitude.
					aToolbar
						addItem:
							(BrButton new
								beSmallSize;
								aptitude: BrGlamorousButtonWithIconAptitude;
								icon: BrGlamorousIcons play asElement;
								label: 'Slideshow' asString;
								action: [ slidesContainer dispatchEvent: BrWithMaximizerAptitudeMaximizeWish new ]);
						addItem:
							(BrToggle new
								beSmallSize;
								aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
								icon: BrGlamorousIcons edit asElement;
								label: 'Update arrows' asString;
								when: BrToggleActivatedEvent
									do: [ :anEvent |
										self slides ifNotEmpty: [
											arrowsAreVisible := true.
											self updateArrows ]];
								when: BrToggleDeactivatedEvent
									do: [ :anEvent |
										self slides ifNotEmpty: [
											arrowsAreVisible := false.
											self updateArrows ]]);
						addItem:
							(BrToggle new
								beSmallSize;
								aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
								icon: BrGlamorousIcons browse asElement;
								label: 'Browse slide method' asString;
								when: BrToggleActivatedEvent
									do: [ :anEvent |
										slideEditorVisibility := slideEditorVisibility not.
										self updateSlideEditorState ];
								when: BrToggleDeactivatedEvent
									do: [ :anEvent |
										slideEditorVisibility := slideEditorVisibility not.
										self updateSlideEditorState ]);
						addItem:
							(anExportButton := BrButton new
								beSmallSize;
								aptitude: BrGlamorousButtonWithIconAptitude;
								label: 'Export slides' asString;
								icon: BrGlamorousIcons savetodisk asElement;
								action: [ :aButton | 
									self pager addPage: self slidesExportPage.
									self pager smoothScrollToLast ]).
					el := BlElement new
						size: 700 @ 520;
						addChild: self pager removeFromParent.
					self pager removeAllPages.
					self pager addPage: (BrPagerPageElement new
						weight: 1.0;
						layout: BlLinearLayout vertical;
						addChild: previewsContainer asScrollableElement;
						addChild: aToolbar).
					el ]);
			constraintsDo: [ :c | c linear horizontal alignRight ];
			padding: (BlInsets all: 10);
			yourself.
]

{ #category : #accessing }
GtLiveShow >> slidesExportPage [
	^ BrPagerPageElement new
		weight: 1.0;
		addChild: self dropdownExportStencilFor.
]

{ #category : #accessing }
GtLiveShow >> sortSlidesByPriority [
	self slides sort: [:a :b | a priority < b priority].
]

{ #category : #'private - subscriptions' }
GtLiveShow >> subscribeToSystem [
	| anAction aSubscription |
	anAction := WeakMessageSend receiver: self selector: #onMethodAdded:.
	aSubscription := WeakAnnouncementSubscription new 
		announcer: SystemAnnouncer uniqueInstance;
		announcementClass: MethodAdded;
		action: anAction;
		subscriber: self targetLiveShow.
	 SystemAnnouncer uniqueInstance basicSubscribe: aSubscription.
]

{ #category : #accessing }
GtLiveShow >> targetLiveShow [
	^ targetLiveShow.
]

{ #category : #accessing }
GtLiveShow >> targetLiveShow: aLiveShowClass [
	targetLiveShow := aLiveShowClass.
]

{ #category : #accessing }
GtLiveShow >> title [
	^ title ifNil: [
		self targetLiveShow isClass 
			ifTrue: [ self targetLiveShow name ]
			ifFalse: [ self targetLiveShow className ] ].
]

{ #category : #accessing }
GtLiveShow >> title: anObject [
	title := anObject.
]

{ #category : #'private - subscriptions' }
GtLiveShow >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self targetLiveShow.
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

{ #category : #accessing }
GtLiveShow >> updateMethodForSlide: aSlide [
	| methodString newSlideMethod |
	methodString := aSlide definingMethod compiledMethod sourceCode.
	newSlideMethod := methodString
		copyReplaceAll: ('priority: ', (aSlide priority) asString)
		with: ('priority: ', (aSlide priority + 1) asString).
	
	self targetLiveShow class
		compile: newSlideMethod asString
		classified: 'slides'.
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
							self updateSlideEditorMethod.
							self updateSlidePreviewsLook ])].
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

{ #category : #'api - updating' }
GtLiveShow >> updateSlideEditorMethod [
	| methodCoder |
	(self slideEditor children size > 2) ifTrue: [self slideEditor removeChildAt: 3].
	methodCoder := ((GtPharoMethodCoder 
			forMethod: (self slides at: self currentSlideIndex) definingMethod)
			asExpandedOnlyElement)
				vFitContentLimited;
				hMatchParent.
	self slideEditor
		addChild: (
			(GtPager createWrappedOn: methodCoder)
				maximized
				background: BrGlamorousColors neutralBackgroundColor;
				margin: (BlInsets top: 35 right: 5 bottom: 5 left: 5);
				constraintsDo: [:c |
					c frame vertical alignTop ]).
]

{ #category : #'api - updating' }
GtLiveShow >> updateSlideEditorState [
	slideEditorVisibility
		ifTrue: [
			slideEditor visibility: BlVisibility visible]
		ifFalse: [
			slideEditor visibility: BlVisibility gone].
]

{ #category : #'api - updating' }
GtLiveShow >> updateSlidePreviewsLook [
	self slides
		do: [ :eachSlide |
			(eachSlide slideIndex = self currentSlideIndex)
				ifTrue: [ eachSlide isSlideSelected: true ]
				ifFalse: [ eachSlide isSlideSelected: false ].
			eachSlide updatePreviewElementLook ].
]
