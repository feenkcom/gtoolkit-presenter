Trait {
	#name : #TGtPresenterWithSlidesViewModel,
	#instVars : [
		'slidesViewModel'
	],
	#category : #'GToolkit-Presenter-View Models - Support'
}

{ #category : #'api - slides view model' }
TGtPresenterWithSlidesViewModel >> hasSlidesViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ slidesViewModel notNil
]

{ #category : #'api - slides view model' }
TGtPresenterWithSlidesViewModel >> onPostSlidesViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToSlidesViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - slides view model' }
TGtPresenterWithSlidesViewModel >> onSlidesViewModelChanged [
	"Is sent when a new slidesViewModel is assigned to the receiver.
	Note: #onSlidesViewModelChanged is sent before #subscribeToSlidesViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlidesViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - slides view model' }
TGtPresenterWithSlidesViewModel >> slidesViewModel [
	"Return a not-null slidesViewModel assigned to the receiver"
	<modelGetter: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ slidesViewModel notNil ]
		description: [ 'slidesViewModel should be initialized' ].

	^ slidesViewModel
]

{ #category : #'api - slides view model' }
TGtPresenterWithSlidesViewModel >> slidesViewModel: aSlidesViewModel [
	"Set a not-null slidesViewModel assigned to the receiver"
	<modelSetter: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSlidesViewModel notNil ]
		description: [ 'slidesViewModel must not be nil' ].

	slidesViewModel == aSlidesViewModel
		ifTrue: [ ^ self ].

	slidesViewModel ifNotNil: [ self unsubscribeFromSlidesViewModel ].
	slidesViewModel := aSlidesViewModel.

	self onSlidesViewModelChanged.
	self subscribeToSlidesViewModel.
	self onPostSlidesViewModelChanged
]

{ #category : #'api - slides view model' }
TGtPresenterWithSlidesViewModel >> subscribeToSlidesViewModel [
	"Is sent after a new slidesViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlidesViewModel if the receiver subscribes to them"
	<modelSubscriber: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - slides view model' }
TGtPresenterWithSlidesViewModel >> unsubscribeFromSlidesViewModel [
	"Is sent before a new slidesViewModel is assigned to the receiver.
	Objects that subscribe to slidesViewModel are required to implement this method."
	<modelUnsubscriber: #slides>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
