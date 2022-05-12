Trait {
	#name : #TGtWithSlideShow,
	#instVars : [
		'slideShow'
	],
	#category : #'GToolkit-Presenter-Models - Support'
}

{ #category : #'api - slide show' }
TGtWithSlideShow >> hasSlideShow [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ slideShow notNil
]

{ #category : #'api - slide show' }
TGtWithSlideShow >> onPostSlideShowChanged [
	"I am an optional hook method that is sent after #subscribeToSlideShow.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - slide show' }
TGtWithSlideShow >> onSlideShowChanged [
	"Is sent when a new slideShow is assigned to the receiver.
	Note: #onSlideShowChanged is sent before #subscribeToSlideShow
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideShowChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - slide show' }
TGtWithSlideShow >> slideShow [
	"Return a not-null slideShow assigned to the receiver"
	<modelGetter: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ slideShow notNil ]
		description: [ 'slideShow should be initialized' ].

	^ slideShow
]

{ #category : #'api - slide show' }
TGtWithSlideShow >> slideShow: aSlideShow [
	"Set a not-null slideShow assigned to the receiver"
	<modelSetter: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSlideShow notNil ]
		description: [ 'slideShow must not be nil' ].

	slideShow == aSlideShow
		ifTrue: [ ^ self ].

	slideShow ifNotNil: [ self unsubscribeFromSlideShow ].
	slideShow := aSlideShow.

	self onSlideShowChanged.
	self subscribeToSlideShow.
	self onPostSlideShowChanged
]

{ #category : #'api - slide show' }
TGtWithSlideShow >> subscribeToSlideShow [
	"Is sent after a new slideShow is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSlideShow if the receiver subscribes to them"
	<modelSubscriber: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - slide show' }
TGtWithSlideShow >> unsubscribeFromSlideShow [
	"Is sent before a new slideShow is assigned to the receiver.
	Objects that subscribe to slideShow are required to implement this method."
	<modelUnsubscriber: #slideShow>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
