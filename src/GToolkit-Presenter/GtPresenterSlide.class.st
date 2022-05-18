Class {
	#name : #GtPresenterSlide,
	#superclass : #Object,
	#instVars : [
		'previewScale',
		'slideExtent',
		'stencil',
		'announcer'
	],
	#category : #'GToolkit-Presenter-Models'
}

{ #category : #'api - announcer' }
GtPresenterSlide >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #initialization }
GtPresenterSlide >> initialize [
	super initialize.
	
	"16x9 aspect ration"
	slideExtent := (960@540).
	previewScale := 0.5.
	stencil := [ BlElement new ] asStencil
]

{ #category : #'api - preview scale' }
GtPresenterSlide >> notifyPreviewScaleChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #previewScale>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (GtPresenterSlidePreviewScaleChanged new
		previewScale: self previewScale).
]

{ #category : #'api - slide extent' }
GtPresenterSlide >> notifySlideExtentChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #slideExtent>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (GtPresenterSlideSlideExtentChanged new
		slideExtent: self slideExtent).
]

{ #category : #'api - stencil' }
GtPresenterSlide >> notifyStencilChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #stencil>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (GtPresenterSlideStencilChanged new
		stencil: self stencil).
]

{ #category : #'api - preview scale' }
GtPresenterSlide >> previewScale [
	<return: #Number>
	<propertyGetter: #previewScale>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ previewScale
]

{ #category : #'api - preview scale' }
GtPresenterSlide >> previewScale: aNewPreviewScale [
	<propertySetter: #previewScale>
	<propertyAnnouncement: #GtPresenterSlidePreviewScaleChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterCanNeverBeNilTemplate'>

	(self previewScale = aNewPreviewScale)
		ifTrue: [ ^ self ].

	previewScale := aNewPreviewScale.
	
	self notifyPreviewScaleChanged
]

{ #category : #'api - slide extent' }
GtPresenterSlide >> slideExtent [
	<return: #Point>
	<propertyGetter: #slideExtent>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ slideExtent
]

{ #category : #'api - slide extent' }
GtPresenterSlide >> slideExtent: aNewSlideExtent [
	<propertySetter: #slideExtent>
	<propertyAnnouncement: #GtPresenterSlideSlideExtentChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterCanNeverBeNilTemplate'>

	(self slideExtent = aNewSlideExtent)
		ifTrue: [ ^ self ].

	slideExtent := aNewSlideExtent.
	
	self notifySlideExtentChanged
]

{ #category : #'api - stencil' }
GtPresenterSlide >> stencil [
	<return: #BlStencil>
	<propertyGetter: #stencil>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ stencil
]

{ #category : #'api - stencil' }
GtPresenterSlide >> stencil: aNewStencil [
	<propertySetter: #stencil>
	<propertyAnnouncement: #GtPresenterSlideStencilChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterCanNeverBeNilTemplate'>

	(self stencil = aNewStencil)
		ifTrue: [ ^ self ].

	stencil := aNewStencil.
	
	self notifyStencilChanged
]

{ #category : #'api - announcer' }
GtPresenterSlide >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtPresenterSlide >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPresenterSlide >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtPresenterSlide >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
