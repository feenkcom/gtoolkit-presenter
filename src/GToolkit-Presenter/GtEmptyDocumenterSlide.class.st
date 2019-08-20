Class {
	#name : #GtEmptyDocumenterSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtEmptyDocumenterSlide >> create [
	^ GtInspector createOnPlayBook: (GtDocument new)
]
