Class {
	#name : #GtPlaygroundSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtPlaygroundSlide >> create [
	| book |
	book := GtPlayBook newDefault.
	^ GtInspector createOnPlayBook: book
]
