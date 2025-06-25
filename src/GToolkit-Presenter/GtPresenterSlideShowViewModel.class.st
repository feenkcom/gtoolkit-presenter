Class {
	#name : #GtPresenterSlideShowViewModel,
	#superclass : #Object,
	#traits : 'TGtPresenterWithSlideShow',
	#classTraits : 'TGtPresenterWithSlideShow classTrait',
	#instVars : [
		'announcer',
		'slidesViewModel',
		'currentSlide'
	],
	#category : #'GToolkit-Presenter-View Models'
}

{ #category : #'api - announcer' }
GtPresenterSlideShowViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtPresenterSlideShowViewModel >> createSlidesViewModel [
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #GtPresenterSlidesViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#createChildObjectsTemplate'>
	| childObject |

	childObject := GtPresenterSlidesViewModel new.
	childObject parentSlideShowViewModel: self.
	childObject slides: self slideShow slides.
	^ childObject
]

{ #category : #'api - current slide' }
GtPresenterSlideShowViewModel >> currentSlide [
	<return: #GtPresenterSlideViewModel>
	<propertyGetter: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ currentSlide
]

{ #category : #'api - current slide' }
GtPresenterSlideShowViewModel >> currentSlide: aNewCurrentSlide [
	<propertySetter: #currentSlide>
	<propertyAnnouncement: #GtPresenterSlideShowViewModelCurrentSlideChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterCanNeverBeNilTemplate'>

	(self currentSlide = aNewCurrentSlide)
		ifTrue: [ ^ self ].

	currentSlide := aNewCurrentSlide.
	
	self notifyCurrentSlideChanged
]

{ #category : #'gt-extensions' }
GtPresenterSlideShowViewModel >> gtSlidesListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForOneTemplate'>

	^ aView list
		priority: 5;
		title: 'Slides';
		items: [ self slidesViewModel slideViewModels ]
]

{ #category : #'api - testing' }
GtPresenterSlideShowViewModel >> isFirstSlide: aSlideViewModel [
	^ self slidesViewModel isFirstSlide: aSlideViewModel
]

{ #category : #'api - testing' }
GtPresenterSlideShowViewModel >> isLastSlide: aSlideViewModel [
	^ self slidesViewModel isLastSlide: aSlideViewModel
]

{ #category : #'api - current slide' }
GtPresenterSlideShowViewModel >> notifyCurrentSlideChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (GtPresenterSlideShowViewModelCurrentSlideChanged new
		currentSlide: self currentSlide).
]

{ #category : #'api - slide show' }
GtPresenterSlideShowViewModel >> onSlideShowChanged [
	"Is sent when a new slideShow is assigned to the receiver.
	Note: #onSlideShowChanged is sent before #subscribeToSlideShow
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideShowChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self currentSlide: (self slidesViewModel
		findSlideViewModel: self slideShow firstSlide
		ifFound: [ :aSlideViewModel | aSlideViewModel ]
		ifNone: [ self slidesViewModel createSlideViewModelFor: self slideShow firstSlide ])
]

{ #category : #'api - accessing' }
GtPresenterSlideShowViewModel >> slidesViewModel [
	"Return a composite object (${class:nil}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #GtPresenterSlidesViewModel>
	<childObjectGetter: #slides>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForOneTemplate>>#childObjectsTemplate'>

	^ slidesViewModel ifNil: [ slidesViewModel := self createSlidesViewModel ]
]

{ #category : #'api - current slide' }
GtPresenterSlideShowViewModel >> switchToNextSlide [
	self slidesViewModel
		slideAfter: currentSlide
		do: [ :aNextSlide | self currentSlide: aNextSlide ]
]

{ #category : #'api - current slide' }
GtPresenterSlideShowViewModel >> switchToPreviousSlide [
	self slidesViewModel
		slideBefore: currentSlide
		do: [ :aPreviousSlide | self currentSlide: aPreviousSlide ]
]

{ #category : #'api - announcer' }
GtPresenterSlideShowViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtPresenterSlideShowViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPresenterSlideShowViewModel >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock for: aSubscriber
]

{ #category : #'api - announcer' }
GtPresenterSlideShowViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
