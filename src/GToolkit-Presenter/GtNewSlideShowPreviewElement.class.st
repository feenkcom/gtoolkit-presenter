"
#Live show preview
Is responsible for displaying a preview of all slides in a slideshow. A preview of a slide is a static scaled down image generated from the slide content after it is done loading.
"
Class {
	#name : #GtNewSlideShowPreviewElement,
	#superclass : #BlElement,
	#traits : 'TGtWithSlideShow + TBrLayoutResizable',
	#classTraits : 'TGtWithSlideShow classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'previews'
	],
	#category : #'GToolkit-Presenter-Views'
}

{ #category : #initialization }
GtNewSlideShowPreviewElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	
	previews := BrGridList new.
	previews aptitudeDo: [ :anAptitude | anAptitude columnCount: 3 ].
	previews hFitContent; vMatchParent.
	previews stencil: [ :eachSlide |
		GtNewSlidePreviewElement new
			exact: 96@54;
			aptitude: (BrShadowAptitude new);
			margin: (BlInsets all: 6);
			background: Color white;
			slide: eachSlide ].

	self matchParent.

	self addChild: previews
]

{ #category : #'api - slide show' }
GtNewSlideShowPreviewElement >> onSlideShowChanged [
	"Is sent when a new slideShow is assigned to the receiver.
	Note: #onSlideShowChanged is sent before #subscribeToSlideShow
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideShowChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	previews items: self slideShow slides
]
