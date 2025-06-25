Class {
	#name : #GtPresenterSlidesViewModel,
	#superclass : #Object,
	#traits : 'TGtPresenterWithSlides',
	#classTraits : 'TGtPresenterWithSlides classTrait',
	#instVars : [
		'parentSlideShowViewModel',
		'announcer',
		'slideViewModels'
	],
	#category : #'GToolkit-Presenter-View Models'
}

{ #category : #'api - adding' }
GtPresenterSlidesViewModel >> addSlide: aSlide [
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition to the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#addDelegateTemplate'>
	self slides addSlide: aSlide
]

{ #category : #'api - announcer' }
GtPresenterSlidesViewModel >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
	"Dispatch anAnnouncement to the parent objects if they are assigned"
	self hasParentSlideShowViewModel
		ifTrue: [ self parentSlideShowViewModel announce: anAnnouncement ].
]

{ #category : #'private - instance creation' }
GtPresenterSlidesViewModel >> createSlideViewModelFor: aChildModel [
	<return: #GtPresenterSlideViewModel>
	<childObjectCreator: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildTemplate'>
	| aNewChild |
	
	aNewChild := GtPresenterSlideViewModel new.
	aNewChild parentSlidesViewModel: self.
	aNewChild slide: aChildModel.
	^ aNewChild
]

{ #category : #'private - instance creation' }
GtPresenterSlidesViewModel >> createSlideViewModels [
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #GtPresenterSlideViewModel>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#createChildObjectsTemplate'>

	^ self slides slides collect: [ :eachModel |
		self createSlideViewModelFor: eachModel ] as: OrderedCollection
]

{ #category : #'api - accessing' }
GtPresenterSlidesViewModel >> findSlideViewModel: aSlide [
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #GtPresenterSlideViewModel or: nil>
	<childObjectDetector: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectTemplate'>

	^ self
		findSlideViewModel: aSlide
		ifFound: [ :aSlideViewModel | aSlideViewModel ]
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
GtPresenterSlidesViewModel >> findSlideViewModel: aSlide ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#findObjectIfFoundIfNoneTemplate'>

	^ self slideViewModels
		detect: [ :eachSlideViewModel |
			eachSlideViewModel slide = aSlide ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - slides' }
GtPresenterSlidesViewModel >> firstSlide [
	"Return the view model of the first slide"

	^ self
		slideAt: 1
		do: [ :aSlide | aSlide ]
]

{ #category : #'gt-extensions' }
GtPresenterSlidesViewModel >> gtSlideListViewFor: aView [
	<gtView>
	<generatedFrom: #'GtRobocoderMetamodelPhlowListViewDerive>>#listForManyTemplate'>

	^ aView list
		priority: 5;
		title: 'Slide';
		items: [ self slideViewModels ]
]

{ #category : #'api - testing' }
GtPresenterSlidesViewModel >> hasParentSlideShowViewModel [
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #slideShow>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectTesterTemplate'>

	^ parentSlideShowViewModel notNil
]

{ #category : #'api - testing' }
GtPresenterSlidesViewModel >> includesSlideViewModel: aSlideViewModel [
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#includesObjectTemplate'>

	^ self slideViewModels anySatisfy: [ :eachSlideViewModel |
		eachSlideViewModel == aSlideViewModel ]
]

{ #category : #'api - testing' }
GtPresenterSlidesViewModel >> isFirstSlide: aSlideViewModel [
	^ self slideViewModels first = aSlideViewModel
]

{ #category : #'api - testing' }
GtPresenterSlidesViewModel >> isLastSlide: aSlideViewModel [
	^ self slideViewModels last = aSlideViewModel
]

{ #category : #'private - notifying' }
GtPresenterSlidesViewModel >> notifySlideViewModelAdded: aSlideViewModel [
	"Notifies that a given child object was added to the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#notifyObjectAddedTemplate'>
	self announce: (GtPresenterSlideViewModelAddedAnnouncement new
		slideViewModel: aSlideViewModel) 
]

{ #category : #'private - notifying' }
GtPresenterSlidesViewModel >> notifySlideViewModelRemoved: aSlideViewModel [
	"Notifies that a given child object was removed from the receiver"
	
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#notifyObjectRemovedTemplate'>
	self announce: (GtPresenterSlideViewModelRemovedAnnouncement new
		slideViewModel: aSlideViewModel) 
]

{ #category : #'private - event handling' }
GtPresenterSlidesViewModel >> onSlideAdded: aGtPresenterSlideAddedAnnouncement [
	"Is sent when a new Slide is added to the model of the receiver due to
	the handled ${class:GtPresenterSlideAddedAnnouncement}$ announcement."
	<modelEventHandler: #slide event: #GtPresenterSlideAddedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#onAddedEventHanderTemplate'>
	| aNewChildObject |

	aNewChildObject := self createSlideViewModelFor: aGtPresenterSlideAddedAnnouncement slide.
	self slideViewModels add: aNewChildObject.
	self onSlideViewModelAdded: aNewChildObject
]

{ #category : #'private - event handling' }
GtPresenterSlidesViewModel >> onSlideRemoved: aGtPresenterSlideRemovedAnnouncement [
	"Is sent when an existing Slide is removed from the model of the receiver due to
	the handled ${class:GtPresenterSlideRemovedAnnouncement}$ announcement."
	<modelEventHandler: #slide event: #GtPresenterSlideRemovedAnnouncement>
	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#onRemovedEventHanderTemplate'>
	| aChildObject |
	
	aChildObject := (self findSlideViewModel: aGtPresenterSlideRemovedAnnouncement slide)
		ifNil: [ ^ self ].

	self slideViewModels
		remove: aChildObject
		ifAbsent: [ ^ self ].

	self onSlideViewModelRemoved: aChildObject
]

{ #category : #'api - adding' }
GtPresenterSlidesViewModel >> onSlideViewModelAdded: aSlideViewModel [
	"Is sent after a given child object was added to the receiver"
	<generatedFrom: #'TGtRobocoderMetamodelAdditionForManyTemplate>>#objectAddedHookTemplate'>
	aSlideViewModel parentSlidesViewModel: self.
	self notifySlideViewModelAdded: aSlideViewModel.
]

{ #category : #'api - adding' }
GtPresenterSlidesViewModel >> onSlideViewModelRemoved: aSlideViewModel [
	"Is sent after a given child object was removed from the receiver"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#objectRemovedHookTemplate'>
	self notifySlideViewModelRemoved: aSlideViewModel.
]

{ #category : #'api - accessing' }
GtPresenterSlidesViewModel >> parentSlideShowViewModel [
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #GtPresenterSlideShowViewModel>
	<parentObjectGetter: #slideShow>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectGetterTemplate'>

	self
		assert: [ parentSlideShowViewModel notNil ]
		description: [ 'Parent is not assigned!' ].

	^ parentSlideShowViewModel
]

{ #category : #'api - accessing' }
GtPresenterSlidesViewModel >> parentSlideShowViewModel: aGtPresenterSlideShowViewModel [
	"Assign a parent object (${class:GtPresenterSlideShowViewModel}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #slideShow>
	<generatedFrom: #'TGtRobocoderMetamodelParentAccessorTemplate>>#parentObjectSetterTemplate'>

	self
		assert: [ aGtPresenterSlideShowViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentSlideShowViewModel := aGtPresenterSlideShowViewModel
]

{ #category : #'api - adding' }
GtPresenterSlidesViewModel >> removeSlide: aSlide [
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal from the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	<generatedFrom: #'TGtRobocoderMetamodelRemovalForManyTemplate>>#removeDelegateTemplate'>
	self slides removeSlide: aSlide
]

{ #category : #'api - slides' }
GtPresenterSlidesViewModel >> slideAfter: aSlideViewModel do: aBlock [
	| aSlideIndex |
	
	aSlideIndex := self slideViewModels
		indexOf: aSlideViewModel
		ifAbsent: [ ^ self ].

	self
		slideAt: aSlideIndex + 1
		do: aBlock
]

{ #category : #'api - slides' }
GtPresenterSlidesViewModel >> slideAt: aSlideIndex do: aBlock [
	| aSlide |

	aSlide := self slideViewModels
		at: aSlideIndex
		ifAbsent: [ ^ self ].
		
	aBlock value: aSlide
]

{ #category : #'api - slides' }
GtPresenterSlidesViewModel >> slideBefore: aSlideViewModel do: aBlock [
	| aSlideIndex |
	
	aSlideIndex := self slideViewModels
		indexOf: aSlideViewModel
		ifAbsent: [ ^ self ].

	self
		slideAt: aSlideIndex - 1
		do: aBlock
]

{ #category : #'api - accessing' }
GtPresenterSlidesViewModel >> slideViewModels [
	"Return a collection of objects (${class:GtPresenterSlideViewModel}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #GtPresenterSlideViewModel>
	<childObjectGetter: #slide>
	<generatedFrom: #'TGtRobocoderMetamodelChildrenForManyWithModelTemplate>>#childObjectsTemplate'>

	^  slideViewModels ifNil: [ slideViewModels := self createSlideViewModels ]
]

{ #category : #'api - slides' }
GtPresenterSlidesViewModel >> subscribeToSlides [
	"Is sent after a new slides is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlides if the receiver subscribes to them"
	<modelSubscriber: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - announcer' }
GtPresenterSlidesViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - slides' }
GtPresenterSlidesViewModel >> unsubscribeFromSlides [
	"Is sent before a new slides is assigned to the receiver.
	Objects that subscribe to slides are required to implement this method."
	<modelUnsubscriber: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]

{ #category : #'api - announcer' }
GtPresenterSlidesViewModel >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPresenterSlidesViewModel >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock for: aSubscriber
]

{ #category : #'api - announcer' }
GtPresenterSlidesViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
