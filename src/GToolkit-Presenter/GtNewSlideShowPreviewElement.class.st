"
#Live show preview
Is responsible for displaying a preview of all slides in a slideshow. A preview of a slide is a static scaled down image generated from the slide content after it is done loading.
"
Class {
	#name : #GtNewSlideShowPreviewElement,
	#superclass : #BlElement,
	#traits : 'TGtPresenterWithSlideShowViewModel + TBrLayoutResizable',
	#classTraits : 'TGtPresenterWithSlideShowViewModel classTrait + TBrLayoutResizable classTrait',
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
	previews stencil: [ :eachSlideViewModel |
		GtPresenterSlidePreviewElement new
			exact: 96@54;
			aptitude: (BrShadowAptitude new);
			margin: (BlInsets all: 6);
			background: Color white;
			slideViewModel: eachSlideViewModel;
			when: BlClickEvent do: [ :aClickEvent |
				aClickEvent consumed: true.
				slideShowViewModel currentSlide: eachSlideViewModel ] ].

	self matchParent.

	self addChild: previews
]

{ #category : #'api - slide show view model' }
GtNewSlideShowPreviewElement >> onSlideShowViewModelChanged [
	"Is sent when a new slideShowViewModel is assigned to the receiver.
	Note: #onSlideShowViewModelChanged is sent before #subscribeToSlideShowViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSlideShowViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	previews items: self slideShowViewModel slidesViewModel slideViewModels
]
