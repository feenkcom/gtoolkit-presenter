Class {
	#name : #GtNewSlidePreviewElement,
	#superclass : #BlElement,
	#traits : 'TGtWithSlide + TBrLayoutResizable',
	#classTraits : 'TGtWithSlide classTrait + TBrLayoutResizable classTrait',
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #initialization }
GtNewSlidePreviewElement >> initialize [
	super initialize.
	
	self beInSingleCompositionLayer.
	self withAsyncFutureDo: [ :anElementFuture |
		anElementFuture
			executionConfiguration: (AsyncFutureExecutionConfiguration new customGroup: #Slides);
			strategy: BrAsyncElementFutureWhenVisibleStrategy new.
		anElementFuture
			whenError: [ :aSlidePreviewElement :anError |
				self removeChildren.
				aSlidePreviewElement addChild: anError asDebuggableElement matchParent ];
			whenSuccess: [ :aSlidePreviewElement :aSlideArtifact |
				self removeChildren.
				aSlidePreviewElement addChild: aSlideArtifact slidePreview asElement asScalableElement ] ]
]

{ #category : #'api - slide' }
GtNewSlidePreviewElement >> onSlideChanged [
	"Is sent when a new slide is assigned to the receiver.
	Note: #onSlideChanged is sent before #subscribeToSlide
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self asyncFuture future: self slide slideArtifact
]
