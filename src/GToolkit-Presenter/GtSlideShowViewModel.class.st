Class {
	#name : #GtSlideShowViewModel,
	#superclass : #Object,
	#traits : 'TGtWithSlideShow',
	#classTraits : 'TGtWithSlideShow classTrait',
	#instVars : [
		'announcer',
		'currentSlide'
	],
	#category : #'GToolkit-Presenter-View Models'
}

{ #category : #'api - announcer' }
GtSlideShowViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - current slide' }
GtSlideShowViewModel >> currentSlide [
	<return: #Object>
	<propertyGetter: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ currentSlide
]

{ #category : #'api - current slide' }
GtSlideShowViewModel >> currentSlide: aNewCurrentSlide [
	<propertySetter: #currentSlide>
	<propertyAnnouncement: #GtSlideShowViewModelCurrentSlideChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasCurrentSlide
		and: [ self currentSlide = aNewCurrentSlide ])
			ifTrue: [ ^ self ].
	
	self hasCurrentSlide
		ifTrue: [
			| aPreviousCurrentSlide |
			aPreviousCurrentSlide := currentSlide.
			currentSlide := nil.
			self onPreviousCurrentSlideUnset: aPreviousCurrentSlide ].
	currentSlide := aNewCurrentSlide.
	self onNewCurrentSlideSet: aNewCurrentSlide.
	self notifyCurrentSlideChanged
]

{ #category : #'api - current slide' }
GtSlideShowViewModel >> hasCurrentSlide [
	<return: #Boolean>
	<propertyTester: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ currentSlide notNil
]

{ #category : #'api - current slide' }
GtSlideShowViewModel >> notifyCurrentSlideChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (GtSlideShowViewModelCurrentSlideChanged new
		currentSlide: self currentSlide).
]

{ #category : #'api - current slide' }
GtSlideShowViewModel >> onNewCurrentSlideSet: aNewCurrentSlide [
	"Is sent after a new value of the currentSlide is assigned"
	<propertySetHook: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - current slide' }
GtSlideShowViewModel >> onPreviousCurrentSlideUnset: aPreviousCurrentSlide [
	"Is sent after a previous value of the currentSlide is de-assigned"
	<propertyUnsetHook: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - current slide' }
GtSlideShowViewModel >> unsetCurrentSlide [
	<propertyUnsetter: #currentSlide>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousCurrentSlide |

	self hasCurrentSlide
		ifFalse: [ ^ self ].

	aPreviousCurrentSlide := currentSlide.
	currentSlide := nil.
	self onPreviousCurrentSlideUnset: aPreviousCurrentSlide.
	self notifyCurrentSlideChanged
]

{ #category : #'api - announcer' }
GtSlideShowViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtSlideShowViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtSlideShowViewModel >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtSlideShowViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
