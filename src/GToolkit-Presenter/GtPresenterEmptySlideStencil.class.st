Class {
	#name : #GtPresenterEmptySlideStencil,
	#superclass : #BrStencil,
	#category : #'GToolkit-Presenter-Models'
}

{ #category : #accessing }
GtPresenterEmptySlideStencil class >> leJsonV4Name [
	^ #presenterEmptySlideStencil
]

{ #category : #'api - instantiation' }
GtPresenterEmptySlideStencil >> create [
	<return: #Object>

	^ BlElement new
]
