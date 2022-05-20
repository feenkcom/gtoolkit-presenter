Class {
	#name : #GtPresenterSlides,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'slides'
	],
	#category : #'GToolkit-Presenter-Models'
}

{ #category : #accessing }
GtPresenterSlides class >> leJsonV4AttributeMapping [
	"Answer the Array of attribute to store keys.
	Subclasses should override this with their attributes."

	^ { #slides -> #slides }
]

{ #category : #accessing }
GtPresenterSlides class >> leJsonV4Name [
	^ #presenterSlides
]

{ #category : #'api - adding' }
GtPresenterSlides >> addSlide: aSlide [
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addObjectTemplate'>

	(self includesSlide: aSlide)
		ifTrue: [ ^ self ].
	
	
	self slides add: aSlide.
	self onSlideAdded: aSlide
]

{ #category : #'api - announcer' }
GtPresenterSlides >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'gt-extensions' }
GtPresenterSlides >> gtSlideListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Slide';
		items: [ self slides ]
]

{ #category : #'api - testing' }
GtPresenterSlides >> includesSlide: aSlide [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#includesObjectTemplate'>

	^ self slides anySatisfy: [ :eachSlide |
		eachSlide == aSlide ]
]

{ #category : #'private - notifying' }
GtPresenterSlides >> notifySlideAdded: aSlide [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (GtPresenterSlideAddedAnnouncement new
		slide: aSlide) 
]

{ #category : #'private - notifying' }
GtPresenterSlides >> notifySlideRemoved: aSlide [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (GtPresenterSlideRemovedAnnouncement new
		slide: aSlide) 
]

{ #category : #'api - adding' }
GtPresenterSlides >> onSlideAdded: aSlide [
	"Is sent after a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	self notifySlideAdded: aSlide.
]

{ #category : #'api - adding' }
GtPresenterSlides >> onSlideRemoved: aSlide [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifySlideRemoved: aSlide.
]

{ #category : #'api - adding' }
GtPresenterSlides >> removeSlide: aSlide [
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeObjectTemplate'>

	(self includesSlide: aSlide)
		ifFalse: [ ^ self ].
	
	
	self slides
		remove: aSlide
		ifAbsent: [ ^ self ].
	self onSlideRemoved: aSlide
]

{ #category : #'api - accessing' }
GtPresenterSlides >> slides [
	"Return a collection of objects (${class:GtPresenterSlide}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #GtPresenterSlide>
	<childObjectGetter: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsGetterTemplate'>

	^ slides ifNil: [ slides := OrderedCollection new ]
]

{ #category : #'api - accessing' }
GtPresenterSlides >> slides: aCollectionOfGtPresenterSlide [
	"Silently assign a collection of given objects as my children without triggering any event. This is part of the #initialization protocol."
	<modelSetter: #slides>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate>>#childObjectsSetterTemplate'>
	
	slides := aCollectionOfGtPresenterSlide asOrderedCollection.
	
]

{ #category : #'api - announcer' }
GtPresenterSlides >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtPresenterSlides >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPresenterSlides >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtPresenterSlides >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
