Trait {
	#name : #TGtPresenterWithSlideViewModel,
	#instVars : [
		'slideViewModel'
	],
	#category : #'GToolkit-Presenter-View Models - Support'
}

{ #category : #'api - slide view model' }
TGtPresenterWithSlideViewModel >> hasSlideViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ slideViewModel notNil
]

{ #category : #'api - slide view model' }
TGtPresenterWithSlideViewModel >> onPostSlideViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToSlideViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - slide view model' }
TGtPresenterWithSlideViewModel >> onSlideViewModelChanged [
	"Is sent when a new slideViewModel is assigned to the receiver.
	Note: #onSlideViewModelChanged is sent before #subscribeToSlideViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - slide view model' }
TGtPresenterWithSlideViewModel >> slideViewModel [
	"Return a not-null slideViewModel assigned to the receiver"
	<modelGetter: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ slideViewModel notNil ]
		description: [ 'slideViewModel should be initialized' ].

	^ slideViewModel
]

{ #category : #'api - slide view model' }
TGtPresenterWithSlideViewModel >> slideViewModel: aSlideViewModel [
	"Set a not-null slideViewModel assigned to the receiver"
	<modelSetter: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSlideViewModel notNil ]
		description: [ 'slideViewModel must not be nil' ].

	slideViewModel == aSlideViewModel
		ifTrue: [ ^ self ].

	slideViewModel ifNotNil: [ self unsubscribeFromSlideViewModel ].
	slideViewModel := aSlideViewModel.

	self onSlideViewModelChanged.
	self subscribeToSlideViewModel.
	self onPostSlideViewModelChanged
]

{ #category : #'api - slide view model' }
TGtPresenterWithSlideViewModel >> subscribeToSlideViewModel [
	"Is sent after a new slideViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlideViewModel if the receiver subscribes to them"
	<modelSubscriber: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - slide view model' }
TGtPresenterWithSlideViewModel >> unsubscribeFromSlideViewModel [
	"Is sent before a new slideViewModel is assigned to the receiver.
	Objects that subscribe to slideViewModel are required to implement this method."
	<modelUnsubscriber: #slide>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
