Class {
	#name : #GtPresenterSlideViewModel,
	#superclass : #Object,
	#traits : 'TGtPresenterWithSlide',
	#classTraits : 'TGtPresenterWithSlide classTrait',
	#instVars : [
		'parentSlidesViewModel',
		'announcer',
		'artifactCache'
	],
	#category : #'GToolkit-Presenter-View Models'
}

{ #category : #'api - announcer' }
GtPresenterSlideViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentSlidesViewModel
		ifTrue: [ self parentSlidesViewModel announce: anAnnouncement ].
]

{ #category : #'api - testing' }
GtPresenterSlideViewModel >> hasParentSlidesViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #slides>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentSlidesViewModel notNil
]

{ #category : #initialization }
GtPresenterSlideViewModel >> initialize [
	super initialize.
	
	artifactCache := AsyncFutureCache new
]

{ #category : #'api - preview scale' }
GtPresenterSlideViewModel >> onSlidePreviewScaleChanged: aGtPresenterSlidePreviewScaleChanged [
	<modelEventHandler: #slide event: #GtPresenterSlidePreviewScaleChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aGtPresenterSlidePreviewScaleChanged
]

{ #category : #'api - slide extent' }
GtPresenterSlideViewModel >> onSlideSlideExtentChanged: aGtPresenterSlideSlideExtentChanged [
	<modelEventHandler: #slide event: #GtPresenterSlideSlideExtentChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aGtPresenterSlideSlideExtentChanged
]

{ #category : #'api - stencil' }
GtPresenterSlideViewModel >> onSlideStencilChanged: aGtPresenterSlideStencilChanged [
	<modelEventHandler: #slide event: #GtPresenterSlideStencilChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#onPropertyChangedTemplate'>
	
	self announce: aGtPresenterSlideStencilChanged
]

{ #category : #'api - accessing' }
GtPresenterSlideViewModel >> parentSlidesViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #GtPresenterSlidesViewModel>
	<parentObjectGetter: #slides>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentSlidesViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentSlidesViewModel
]

{ #category : #'api - accessing' }
GtPresenterSlideViewModel >> parentSlidesViewModel: aGtPresenterSlidesViewModel [
	"Assign a parent object (${class:GtPresenterSlidesViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #slides>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGtPresenterSlidesViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentSlidesViewModel := aGtPresenterSlidesViewModel
]

{ #category : #'api - preview scale' }
GtPresenterSlideViewModel >> previewScale [
	<propertyGetter: #previewScale>
	<return: #Number>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self slide previewScale
]

{ #category : #'api - preview scale' }
GtPresenterSlideViewModel >> previewScale: aPreviewScale [
	<propertySetter: #previewScale>
	<propertyAnnouncement: #GtPresenterSlidePreviewScaleChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self slide previewScale: aPreviewScale
]

{ #category : #private }
GtPresenterSlideViewModel >> privateCreateSlideAtrifact [
	<return: #GtPresenterSlideArtifact>
	| aScripter aSlidePreview aSlideElement |
	
	aScripter := BlScripter new.
	aScripter extent: self slideExtent.
	aScripter element: self stencil asElement.
	
	aSlidePreview := BlExporter form
		element: aScripter element;
		scaled: self previewScale;
		export.

	aSlideElement := aScripter elementWithoutParent.
	
	^ GtPresenterSlideArtifact new
		slideElement: aSlideElement preview: aSlidePreview
]

{ #category : #private }
GtPresenterSlideViewModel >> privateSlideArtifactFuture [
	^ [ self privateCreateSlideAtrifact ] asAsyncFuture
]

{ #category : #'api - accessing' }
GtPresenterSlideViewModel >> slideArtifact [
	"Return a future that resolves to a slide artifact that contains a slide and its form preview.
	Note: a rendered slide and its preview are internally cached and computed once for each slide generation"
	<return: #TAsyncFuture of: #GtPresenterSlideArtifact>

	^ AsyncCachedFuture
		  forFuture: self privateSlideArtifactFuture
		  cache: artifactCache
]

{ #category : #'api - slide extent' }
GtPresenterSlideViewModel >> slideExtent [
	<propertyGetter: #slideExtent>
	<return: #Point>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self slide slideExtent
]

{ #category : #'api - slide extent' }
GtPresenterSlideViewModel >> slideExtent: aSlideExtent [
	<propertySetter: #slideExtent>
	<propertyAnnouncement: #GtPresenterSlideSlideExtentChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self slide slideExtent: aSlideExtent
]

{ #category : #'api - stencil' }
GtPresenterSlideViewModel >> stencil [
	<propertyGetter: #stencil>
	<return: #BlStencil>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#getterDelegateTemplate'>

	^ self slide stencil
]

{ #category : #'api - stencil' }
GtPresenterSlideViewModel >> stencil: aStencil [
	<propertySetter: #stencil>
	<propertyAnnouncement: #GtPresenterSlideStencilChanged>
	<generatedFrom: #'TGtRobocoderMetamodelPropertyMirrorTemplate>>#setterDelegateTemplate'>

	self slide stencil: aStencil
]

{ #category : #'api - slide' }
GtPresenterSlideViewModel >> subscribeToSlide [
	"Is sent after a new slide is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlide if the receiver subscribes to them"
	<modelSubscriber: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
GtPresenterSlideViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - slide' }
GtPresenterSlideViewModel >> unsubscribeFromSlide [
	"Is sent before a new slide is assigned to the receiver.
	Objects that subscribe to slide are required to implement this method."
	<modelUnsubscriber: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
GtPresenterSlideViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPresenterSlideViewModel >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock for: aSubscriber
]

{ #category : #'api - announcer' }
GtPresenterSlideViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
