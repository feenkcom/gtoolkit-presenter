Class {
	#name : 'GtConnectorForExampleSlide',
	#superclass : 'GtSlide',
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtConnectorForExampleSlide >> create [
	^ ((BlFrameLayoutCompositionExamples>>#example) gtExample gtConnectionsFor: GtPhlowEmptyView new)
		asElementDo: [ :anElement | ^ anElement  ]
]
