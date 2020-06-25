Class {
	#name : #GtBaselineOfGToolkitCommentSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtBaselineOfGToolkitCommentSlide >> create [
	^ GtPager createWrappedOn: (GtDocumenter forClass: BaselineOfGToolkit)
]
