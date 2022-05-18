Trait {
	#name : #TGtPresenterWithSlide,
	#instVars : [
		'slide'
	],
	#category : #'GToolkit-Presenter-Models - Support'
}

{ #category : #'api - slide' }
TGtPresenterWithSlide >> hasSlide [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ slide notNil
]

{ #category : #'api - slide' }
TGtPresenterWithSlide >> onPostSlideChanged [
	"I am an optional hook method that is sent after #subscribeToSlide.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - slide' }
TGtPresenterWithSlide >> onSlideChanged [
	"Is sent when a new slide is assigned to the receiver.
	Note: #onSlideChanged is sent before #subscribeToSlide
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - slide' }
TGtPresenterWithSlide >> slide [
	"Return a not-null slide assigned to the receiver"
	<modelGetter: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ slide notNil ]
		description: [ 'slide should be initialized' ].

	^ slide
]

{ #category : #'api - slide' }
TGtPresenterWithSlide >> slide: aSlide [
	"Set a not-null slide assigned to the receiver"
	<modelSetter: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSlide notNil ]
		description: [ 'slide must not be nil' ].

	slide == aSlide
		ifTrue: [ ^ self ].

	slide ifNotNil: [ self unsubscribeFromSlide ].
	slide := aSlide.

	self onSlideChanged.
	self subscribeToSlide.
	self onPostSlideChanged
]

{ #category : #'api - slide' }
TGtPresenterWithSlide >> subscribeToSlide [
	"Is sent after a new slide is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlide if the receiver subscribes to them"
	<modelSubscriber: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - slide' }
TGtPresenterWithSlide >> unsubscribeFromSlide [
	"Is sent before a new slide is assigned to the receiver.
	Objects that subscribe to slide are required to implement this method."
	<modelUnsubscriber: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
