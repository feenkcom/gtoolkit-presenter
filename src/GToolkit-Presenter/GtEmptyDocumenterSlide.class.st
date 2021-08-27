Class {
	#name : 'GtEmptyDocumenterSlide',
	#superclass : 'GtSlide',
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtEmptyDocumenterSlide >> create [
	^ GtPager new 
		createWrappedOn: GtDocumenter new
]
