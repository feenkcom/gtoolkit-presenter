Trait {
	#name : #TGtPresenterWithSlides,
	#instVars : [
		'slides'
	],
	#category : #'GToolkit-Presenter-Models - Support'
}

{ #category : #'api - slides' }
TGtPresenterWithSlides >> hasSlides [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ slides notNil
]

{ #category : #'api - slides' }
TGtPresenterWithSlides >> onPostSlidesChanged [
	"I am an optional hook method that is sent after #subscribeToSlides.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - slides' }
TGtPresenterWithSlides >> onSlidesChanged [
	"Is sent when a new slides is assigned to the receiver.
	Note: #onSlidesChanged is sent before #subscribeToSlides
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlidesChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - slides' }
TGtPresenterWithSlides >> slides [
	"Return a not-null slides assigned to the receiver"
	<modelGetter: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ slides notNil ]
		description: [ 'slides should be initialized' ].

	^ slides
]

{ #category : #'api - slides' }
TGtPresenterWithSlides >> slides: aSlides [
	"Set a not-null slides assigned to the receiver"
	<modelSetter: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSlides notNil ]
		description: [ 'slides must not be nil' ].

	slides == aSlides
		ifTrue: [ ^ self ].

	slides ifNotNil: [ self unsubscribeFromSlides ].
	slides := aSlides.

	self onSlidesChanged.
	self subscribeToSlides.
	self onPostSlidesChanged
]

{ #category : #'api - slides' }
TGtPresenterWithSlides >> subscribeToSlides [
	"Is sent after a new slides is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlides if the receiver subscribes to them"
	<modelSubscriber: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - slides' }
TGtPresenterWithSlides >> unsubscribeFromSlides [
	"Is sent before a new slides is assigned to the receiver.
	Objects that subscribe to slides are required to implement this method."
	<modelUnsubscriber: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
