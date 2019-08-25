Class {
	#name : #GtBaselineOfGToolkitCommentSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtBaselineOfGToolkitCommentSlide >> create [
	^ GtInspector createOnPlayBook: (GtDocument forClass: BaselineOfGToolkit)
]
