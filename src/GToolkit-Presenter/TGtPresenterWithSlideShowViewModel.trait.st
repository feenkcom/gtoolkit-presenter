Trait {
	#name : #TGtPresenterWithSlideShowViewModel,
	#instVars : [
		'slideShowViewModel'
	],
	#category : #'GToolkit-Presenter-View Models - Support'
}

{ #category : #'api - slide show view model' }
TGtPresenterWithSlideShowViewModel >> hasSlideShowViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ slideShowViewModel notNil
]

{ #category : #'api - slide show view model' }
TGtPresenterWithSlideShowViewModel >> onPostSlideShowViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToSlideShowViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - slide show view model' }
TGtPresenterWithSlideShowViewModel >> onSlideShowViewModelChanged [
	"Is sent when a new slideShowViewModel is assigned to the receiver.
	Note: #onSlideShowViewModelChanged is sent before #subscribeToSlideShowViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideShowViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - slide show view model' }
TGtPresenterWithSlideShowViewModel >> slideShowViewModel [
	"Return a not-null slideShowViewModel assigned to the receiver"
	<modelGetter: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ slideShowViewModel notNil ]
		description: [ 'slideShowViewModel should be initialized' ].

	^ slideShowViewModel
]

{ #category : #'api - slide show view model' }
TGtPresenterWithSlideShowViewModel >> slideShowViewModel: aSlideShowViewModel [
	"Set a not-null slideShowViewModel assigned to the receiver"
	<modelSetter: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSlideShowViewModel notNil ]
		description: [ 'slideShowViewModel must not be nil' ].

	slideShowViewModel == aSlideShowViewModel
		ifTrue: [ ^ self ].

	slideShowViewModel ifNotNil: [ self unsubscribeFromSlideShowViewModel ].
	slideShowViewModel := aSlideShowViewModel.

	self onSlideShowViewModelChanged.
	self subscribeToSlideShowViewModel.
	self onPostSlideShowViewModelChanged
]

{ #category : #'api - slide show view model' }
TGtPresenterWithSlideShowViewModel >> subscribeToSlideShowViewModel [
	"Is sent after a new slideShowViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlideShowViewModel if the receiver subscribes to them"
	<modelSubscriber: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - slide show view model' }
TGtPresenterWithSlideShowViewModel >> unsubscribeFromSlideShowViewModel [
	"Is sent before a new slideShowViewModel is assigned to the receiver.
	Objects that subscribe to slideShowViewModel are required to implement this method."
	<modelUnsubscriber: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
