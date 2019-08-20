Class {
	#name : #GtConnectorForExampleSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtConnectorForExampleSlide >> create [
	^ GtInspector createOn: (BlFrameLayoutCompositionExamples>>#example) gtExample
]
