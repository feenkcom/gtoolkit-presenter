Class {
	#name : #GtPresenterSlideElement,
	#superclass : #BlElement,
	#traits : 'TGtPresenterWithSlideViewModel + TBrLayoutResizable',
	#classTraits : 'TGtPresenterWithSlideViewModel classTrait + TBrLayoutResizable classTrait',
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #initialization }
GtPresenterSlideElement >> initialize [
	super initialize.
	
	self matchParent.
	
	self beInSeparateCompositionLayer.
	self withAsyncFutureDo: [ :anElementFuture |
		anElementFuture
			executionConfiguration: (AsyncFutureExecutionConfiguration new customGroup: #Slides);
			strategy: BrAsyncElementFutureWhenVisibleStrategy new.
		anElementFuture
			whenError: [ :aSlideElement :anError |
				self removeChildren.
				aSlideElement addChild: anError asDebuggableElement matchParent ];
			whenSuccess: [ :aSlideElement :aSlideArtifact |
				self removeChildren.
				aSlideElement addChild: aSlideArtifact slideElement removeFromParent asScalableElement ] ]
]

{ #category : #'api - slide view model' }
GtPresenterSlideElement >> onSlideViewModelChanged [
	"Is sent when a new slideViewModel is assigned to the receiver.
	Note: #onSlideViewModelChanged is sent before #subscribeToSlideViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self asyncFuture future: self slideViewModel slideArtifact
]
