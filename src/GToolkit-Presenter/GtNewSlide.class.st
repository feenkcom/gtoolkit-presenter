Class {
	#name : #GtNewSlide,
	#superclass : #Object,
	#instVars : [
		'stencil',
		'artifactCache',
		'slideExtent',
		'previewScale'
	],
	#category : #'GToolkit-Presenter-Model'
}

{ #category : #'gt-extension' }
GtNewSlide >> gtInfoFor: aView [
	<gtView>

	^ ({
		#'Stencil' -> self stencil.
		#'Slide extent' -> self slideExtent.
		#'Preview scale' -> self previewScale.
	 } asOrderedDictionary gtItemsFor: aView)
			title: 'Info';
			priority: 5
]

{ #category : #initialization }
GtNewSlide >> initialize [
	super initialize.
	
	artifactCache := AsyncFutureCache new.
	
	"16x9 aspect ration"
	slideExtent := (960@540).
	previewScale := 0.5
]

{ #category : #testing }
GtNewSlide >> isCached [
	^ artifactCache
		ifSome: [ true ]
		ifNone: [ false ]
]

{ #category : #accessing }
GtNewSlide >> previewScale [
	"Return by how much the slide preview (Form) should differ from the slide itself. Larger preview leads to longer rendering times"
	<return: #Point>

	^ previewScale
]

{ #category : #private }
GtNewSlide >> privateCreateSlideAtrifact [
	<return: #GtNewSlideArtifact>
	| aScripter aSlidePreview aSlideElement |
	
	aScripter := BlDevScripter new.
	aScripter extent: self slideExtent.
	aScripter element: stencil asElement.
	
	aSlidePreview := BlExporter form
		element: aScripter element;
		scaled: self previewScale;
		export.

	aSlideElement := aScripter elementWithoutParent.
	
	^ GtNewSlideArtifact new
		slideElement: aSlideElement preview: aSlidePreview
]

{ #category : #private }
GtNewSlide >> privateSlideArtifactFuture [
	^ [ self privateCreateSlideAtrifact ] asAsyncFuture
]

{ #category : #accessing }
GtNewSlide >> slideArtifact [
	"Return a future that resolves to a slide artifact that contains a slide and its form preview.
	Note: a rendered slide and its preview are internally cached and computed once for each slide generation"
	<return: #TAsyncFuture of: #GtNewSlideArtifact>

	^ AsyncCachedFuture
		  forFuture: self privateSlideArtifactFuture
		  cache: artifactCache
]

{ #category : #accessing }
GtNewSlide >> slideExtent [
	"Return the configured size (in points) of the slide.
	When displayed in presenter mode, the slide content will be downscaled or upscaled from this resolution."
	<return: #Point>

	^ slideExtent
]

{ #category : #accessing }
GtNewSlide >> slideExtent: aPoint [
	"Set slide extent - must be positive. See #slideExtent for more info"

	self
		assert: [ aPoint x > 0 and: [ aPoint y > 0 ] ]
		description: [ 'Slide extent must be positive' ].

	slideExtent := aPoint
]

{ #category : #accessing }
GtNewSlide >> stencil [

	^ stencil
]

{ #category : #accessing }
GtNewSlide >> stencil: anObject [

	stencil := anObject asStencil
]
