Class {
	#name : #GtPresenterSlideExamples,
	#superclass : #Object,
	#category : #'GToolkit-Presenter-Examples-GToolkit-Presenter-Examples'
}

{ #category : #examples }
GtPresenterSlideExamples >> baseSlide [
	<gtExample>
	<return: #GtPresenterSlide>
	| aSlide |
	aSlide := GtPresenterSlide new.

	self assert: aSlide slideExtent equals: 960 @ 540.
	self assert: aSlide previewScale equals: 0.5.

	^ aSlide
]

{ #category : #examples }
GtPresenterSlideExamples >> slideElementWithStencil [
	<gtExample>
	<return: #GtPresenterSlideElement>
	| aSlideViewModel aSlideElement |
	aSlideViewModel := self slideViewModelWithStencil.
	aSlideElement := GtPresenterSlideElement new slideViewModel: aSlideViewModel.

	^ aSlideElement
]

{ #category : #examples }
GtPresenterSlideExamples >> slideViewModelWithStencil [
	<gtExample>
	<return: #GtPresenterSlideViewModel>
	| aSlide aSlideViewModel |
	aSlide := self slideWithStencil.
	aSlideViewModel := GtPresenterSlideViewModel new slide: aSlide.

	self assert: aSlideViewModel slideExtent equals: 960 @ 540.
	self assert: aSlideViewModel previewScale equals: 0.5.
	self assert: (aSlideViewModel stencil isKindOf: BrStencil).

	^ aSlideViewModel
]

{ #category : #examples }
GtPresenterSlideExamples >> slideWithStencil [
	<gtExample>
	<return: #GtPresenterSlide>
	| aSlide |
	aSlide := self baseSlide.
	aSlide
		stencil: [ BlElement new
				background: Color lightGray;
				size: 200 @ 100;
				border: (BlBorder paint: Color gray width: 2) ] asStencil.

	^ aSlide
]
