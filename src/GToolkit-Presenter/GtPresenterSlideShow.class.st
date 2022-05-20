Class {
	#name : #GtPresenterSlideShow,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'slides'
	],
	#category : #'GToolkit-Presenter-Models'
}

{ #category : #'instance creation' }
GtPresenterSlideShow class >> create: aSlideshowObject [
	| theSlides aSlideshow |
	
	theSlides := GtSlidesCollector new
		object: aSlideshowObject;
		from: aSlideshowObject class;
		to: aSlideshowObject class;
		collect.

	theSlides := theSlides sorted: [ :a :b | a priority < b priority ].
	theSlides := theSlides collect: [ :eachSlide |
		GtPresenterSlide new stencil: eachSlide ].
	
	aSlideshow := self new.
	aSlideshow slides slides: theSlides.
	
	^ aSlideshow
]

{ #category : #accessing }
GtPresenterSlideShow class >> openInSpace: aSlideShowClass [
	"Convenience method to open a slideshow in a new window.
	For example: GtPresenterSlideShow openInSpace: GtTour"
	| slideshow slideshowViewModel |
	
	slideshow := self create: aSlideShowClass new.
	slideshowViewModel := GtPresenterSlideShowViewModel new slideShow: slideshow.
	
	BlSpace new
		addChild: (GtPresenterSlideShowElement new slideShowViewModel: slideshowViewModel);
		show
]

{ #category : #'api - announcer' }
GtPresenterSlideShow >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #accessing }
GtPresenterSlideShow >> asElement [
	| slideshowViewModel |
	slideshowViewModel := GtPresenterSlideShowViewModel new slideShow: self.
	^ GtPresenterSlideShowElement new
		slideShowViewModel: slideshowViewModel;
		yourself
]

{ #category : #'private - instance creation' }
GtPresenterSlideShow >> createSlides [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #GtPresenterSlides>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := GtPresenterSlides new.
	
	
	^ childObject
]

{ #category : #'api - accessing' }
GtPresenterSlideShow >> firstSlide [
	<return: #GtPresenterSlide>

	^ self slides slides first
]

{ #category : #'gt-extensions' }
GtPresenterSlideShow >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 5;
		stencil: [ self asElement ]
]

{ #category : #'gt-extensions' }
GtPresenterSlideShow >> gtSlidesListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Slides';
		items: [ self slides slides ]
]

{ #category : #'api - accessing' }
GtPresenterSlideShow >> slides [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #GtPresenterSlides>
	<childObjectGetter: #slides>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ slides ifNil: [ slides := self createSlides ]
]

{ #category : #'api - announcer' }
GtPresenterSlideShow >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtPresenterSlideShow >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPresenterSlideShow >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtPresenterSlideShow >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
